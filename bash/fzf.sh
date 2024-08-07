#!/bin/bash

# Auto-completion
# ---------------
# [[ $- == *i* ]] && source "$(fzf-share)/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "$(fzf-share)/key-bindings.bash"

export FZF_DEFAULT_COMMAND='fd --type f . -H --ignore'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--height 100% --preview '(bat --color always --style changes --paging never --theme 1337 {} || cat {}) 2> /dev/null'"

## fzf functions shamelessly copied from their wiki

# Modified version where you can press
#   - CTRL-O to open with `open` command,
#   - CTRL-E or Enter key to open with the $EDITOR
fo() {
  local out file key IFS=$'\n' out=($(fzf-tmux --query="$1" --exit-0 --expect=ctrl-o,ctrl-e))
  key=$(head -1 <<< "$out")
  file=$(head -2 <<< "$out" | tail -1)
  if [ -n "$file" ]; then
    [ "$key" = ctrl-o ] && open "$file" || ${EDITOR:-vim} "$file"
  fi
}

# fuzzy grep open via ag
vg() {
  local file

  file="$(ag --nobreak --noheading $@ | fzf -0 -1 | awk -F: '{print $1 " +" $2}')"

  if [[ -n $file ]]
  then
     ${EDITOR:-vim} $file
  fi
}

# change to subdirectory
fcd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# autojump
fj() {
    local query, choice
    query="$1"
    choice=`cat ~/Library/autojump/autojump.txt | sort -nr | awk '{print $2}' | fzf +s -q "${query}"`
    cd "${choice}"
}
alias fag="ag --nobreak --nonumbers --noheading . | fzf"

# change branch
fbr() {
  local branches branch
  branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# change branch
frbr() {
  local branches branch
  branches=$(git for-each-ref --count=30 --sort=-committerdate refs/remotes/ --format="%(refname:short)") &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
           git checkout --track $(echo "$branch" | sed "s/.* //") -B $(echo "$branch" | sed "s/^[^/]*\///")
}

# fco_preview - checkout git branch/tag, with a preview showing the commits between the tag/branch and HEAD
fco_preview() {
  local tags branches target
  tags=$(
git tag | awk '{print "\x1b[31;1mtag\x1b[m\t" $1}') || return
  branches=$(
git branch --all | grep -v HEAD |
sed "s/.* //" | sed "s#remotes/[^/]*/##" |
sort -u | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
  target=$(
(echo "$tags"; echo "$branches") |
    fzf --no-hscroll --no-multi --delimiter="\t" -n 2 \
        --ansi --preview="git log -200 --pretty=format:%s $(echo {+2..} |  sed 's/$/../' )" ) || return
  git checkout $(echo "$target" | awk '{print $2}')
}

# fcoc - checkout git commit
fcoc() {
  local commits commit
  commits=$(git log --pretty=oneline --abbrev-commit --reverse) &&
  commit=$(echo "$commits" | fzf --tac +s +m -e) &&
  git checkout $(echo "$commit" | sed "s/ .*//")
}

fherokuapp() {
  RUNCACHED_PERIOD=360 runcached.sh heroku list -A | grep -v '^=' | grep -v '^\s*$' | awk '{ print $1 }' | fzf
}

# open heroshell with proper app
fheroshell() {
  local app
  app=`fherokuapp`
  heroshell "${app}"
}

fherocurl() {
  local app
  app=`fherokuapp`
  hostname=`heroku domains -a ${app} --json | jq '[.[] | {hostname: .hostname, kind: .kind}] | sort_by(.kind) | .[] | .hostname' -r | head -n 1`
  path="$1"
  shift
  curl https://${hostname}/${path#\/} $*
}

fchooseissue() {
  hub issue -f '%I %t %U%n' -o updated | fzf
}

fopenissue() {
  local issue_number
  issue_number=`fchooseissue | cut -f1 -d' '`
  local session_name
  session_name="issue-${issue_number}"
  tmux new -s "${session_name}" "hub issue show ${issue_number} | mdless"
}

fissueurl() {
  local issue_url
  fchooseissue | rev | cut -f1 -d' ' | rev
}
