export PATH=/usr/local/go/bin:/usr/local/bin:/usr/local/git/bin:$PATH:/usr/local/smlnj-110.75/bin:/usr/local/share/python/
export PATH=${HOME}/.local/bin:/usr/local/share/npm/bin:/Users/kubek2k/.cache/rebar3/bin:$PATH

export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_45.jdk/Contents/Home"
export JAVA_HOME_7=$JAVA_HOME

BLACK=$(tput setaf 0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
LIME_YELLOW=$(tput setaf 190)
YELLOW=$(tput setaf 3)
POWDER_BLUE=$(tput setaf 153)
BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7)
BRIGHT=$(tput bold)
NORMAL=$(tput sgr0)
BLINK=$(tput blink)
REVERSE=$(tput smso)
UNDERLINE=$(tput smul)

# show untracked files as %
export GIT_PS1_SHOWUNTRACKEDFILES=1
# show dirty state as * and added files as +
export GIT_PS1_SHOWDIRTYSTATE=1
# prompt definition
#export PS1='\! \[${WHITE}\](\[${YELLOW}\]\u@\h\[${WHITE}\]) \[${RED}\]\w\[${MAGENTA}\] $(__git_ps1 "(%s)") \[${GREEN}\]\$\[${NORMAL}\] '
export PS1='\! ${WHITE}(${YELLOW}\u@\h${WHITE}) ${RED}\w${MAGENTA}${GREEN} \$${NORMAL} '

export LS_COLORS="no=00:fi=00:di=36;40:ln=00;36:pi=40;33:so=00;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=00;32:*.cmd=00;32:*.exe=00;32:*.com=00;32:*.btm=00;32:*.bat=00;32:*.sh=00;32:*.csh=00;32:*.tar=00;31:*.tgz=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.zip=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.bz2=00;31:*.bz=00;31:*.tz=00;31:*.rpm=00;31:*.cpio=00;31:*.jpg=00;35:*.gif=00;35:*.bmp=00;35:*.xbm=00;35:*.xpm=00;35:*.png=00;35:*.tif=00;35:"
export CLICOLOR=1
export LSCOLORS=exfxcxdxbxexexabagacad

function send_notification {
    MESSAGE=$1
    terminal-notifier -message "$MESSAGE" -title "Bash notification"
}

function mci {
    mvn clean install $* && send_notification "`pwd` clean install $* done"
}

function mcp {
    mvn clean package $* && send_notification "`pwd` clean package $* done"
}

function o {
    COMMAND=$*
    $COMMAND && send_notification "'$COMMAND' done" || send_notification "'$COMMAND' not successful'"
}

function connect_to_heroku_psql {
    URL=`heroku config:get -s DATABASE_URL | sed -e 's/DATABASE_URL=//'`
    psql "$URL"
}

function encodeURIComponent() {
    awk 'BEGIN {while (y++ < 125) z[sprintf("%c", y)] = y
    while (y = substr(ARGV[1], ++j, 1))
        q = y ~ /[[:alnum:]_.!~*\47()-]/ ? q y : q sprintf("%%%02X", z[y])
        print q}' "$1"
}

function set_slack_status {
    if [ -z "${SLACK_TOKEN}" ]; then
        echo "Can't set the status because no slack token is provided" >&2
        return 
    fi
    profile=`encodeURIComponent "{\"status_text\": \"$1\", \"status_emoji\": \"$2\"}"`
    curl -X POST "https://slack.com/api/users.profile.set?token=${SLACK_TOKEN}&profile=${profile}"
}

function send_to_slack {
    if [ -z "${SLACK_TOKEN}" ]; then
        echo "Can't set the status because no slack token is provided" >&2
        return 
    fi
    channel=$1
    text=`encodeURIComponent "$2"`
    curl -X POST "https://slack.com/api/chat.postMessage?token=${SLACK_TOKEN}&text=${text}&channel=${channel}&as_user=true"
}

function ocpr {
   if [ "$1" == "" ]; then
       echo "No message provided" > /dev/stderr
       return 1
   fi
   BRANCH_NAME=`echo "$1" | tr '[:upper:]' '[:lower:]' | sed -e 's/[^A-Za-z]/-/g'`
   git checkout -b "$BRANCH_NAME"
   git add .
   git commit -m "$1"
   git push
   hub pull-request
}

# autojump
[[ -s `brew --prefix`/etc/autojump.sh ]] && source `brew --prefix`/etc/autojump.sh

# If this is an xterm set the title to user@host:dir
case "$TERM" in
    xterm*|rxvt*)
        # PROMPT_COMMAND="${PROMPT_COMMAND}; echo -ne \"\033]0;${USER}@${HOSTNAME}: ${PWD}\007\""

        # Show the currently running command in the terminal title:
        # http://www.davidpashley.com/articles/xterm-titles-with-bash.html
        show_command_in_title_bar()
        {
            case "$BASH_COMMAND" in
                *\033]0*)
                    # The command is trying to set the title bar as well;
                    # this is most likely the execution of $PROMPT_COMMAND.
                    # In any case nested escapes confuse the terminal, so don't
                    # output them.
                    ;;
                *)
                    echo -ne "\033]0;${BASH_COMMAND}\007"
                    ;;
            esac
        }
        trap show_command_in_title_bar DEBUG
        ;;
    *)
        ;;
esac


# git completion
[[ -s /usr/local/git/contrib/completion/git-completion.bash ]] && source /usr/local/git/contrib/completion/git-completion.bash

# brew completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

# nix completion
if [ -d "$HOME/.nix-profile/etc/bash_completion.d" ]; then
    for f in $HOME/.nix-profile/etc/bash_completion.d/*; do
        source "$f"
    done
fi

[[ -s $HOME/Dotfiles/bash.completion.d ]] && source $HOME/Dotfiles/bash.completion.d/*

[[ -s $HOME/.bashrc.local ]] && source $HOME/.bashrc.local

# added by travis gem
[ -f /Users/kubek2k/.travis/travis.sh ] && source /Users/kubek2k/.travis/travis.sh

export NVM_DIR="/Users/kubek2k/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
