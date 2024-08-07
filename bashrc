export PATH=/usr/local/go/bin:/usr/local/bin:/usr/local/git/bin:$PATH:/usr/local/smlnj-110.75/bin:/usr/local/share/python:${HOME}/Dotfiles/scripts

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

# prompt definition
#export PS1='\! ${WHITE}(${YELLOW}\u@\h${WHITE}) ${RED}\w${MAGENTA}${GREEN} \$${NORMAL} '
if [[ $IN_NIX_SHELL == "impure" ]]; then
    export PROMPT_COMMAND='PS1="(impure) \[${YELLOW}\]\w\[${MAGENTA}\] $(__git_ps1 "(%s)") \[${GREEN}\]\$\[${NORMAL}\] "'
elif [[ $IN_NIX_SHELL == "pure" ]]; then
    export PROMPT_COMMAND='PS1="(pure) \[${LIME_YELLOW}\]\w\[${MAGENTA}\] $(__git_ps1 "(%s)") \[${GREEN}\]\$\[${NORMAL}\] "'
else
    ORIGINAL_PS1='\[${RED}\]\w\[${MAGENTA}\] $(__git_ps1 "(%s)") \[${GREEN}\]\$\[${NORMAL}\] '
    export PS1="$ORIGINAL_PS1"
    # export PROMPT_COMMAND='PS1="\n`soji header`\n\[${NORMAL}\]\[${CYAN}\]`soji status`: ${ORIGINAL_PS1}"'
fi

[[ -s $HOME/.bashrc.local ]] && source $HOME/.bashrc.local

for f in ~/Dotfiles/bash/*; do
    [ -f "$f" ] && source "$f"
done

eval "$(direnv hook bash)"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
