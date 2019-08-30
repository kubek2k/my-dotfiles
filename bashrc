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
ORIGINAL_PS1='\[${RED}\]\w\[${MAGENTA}\] $(__git_ps1 "(%s)") \[${GREEN}\]\$\[${NORMAL}\] '
#export PS1='\! ${WHITE}(${YELLOW}\u@\h${WHITE}) ${RED}\w${MAGENTA}${GREEN} \$${NORMAL} '
export PROMPT_COMMAND='PS1="\n`soji header`\n\[${NORMAL}\]\[${CYAN}\]`soji status`: ${ORIGINAL_PS1}"'

# If this is an xterm set the title to user@host:dir
case "$TERM" in
    xterm*|rxvt*)
        PROMPT_COMMAND="${PROMPT_COMMAND}; echo -ne \"\033]0;${PWD}\007\""
esac

[[ -s $HOME/.bashrc.local ]] && source $HOME/.bashrc.local

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

for f in ~/Dotfiles/bash/*; do
    [ -f "$f" ] && source "$f"
done

eval "$(direnv hook bash)"
