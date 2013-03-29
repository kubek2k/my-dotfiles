export PATH=/usr/local/bin:/usr/local/git/bin:$PATH:/usr/local/smlnj-110.75/bin

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

# git branch name in PS1
[[ -s /usr/share/git-core/git-prompt.sh ]] && source /usr/share/git-core/git-prompt.sh

# show untracked files as %
export GIT_PS1_SHOWUNTRACKEDFILES=1
# show dirty state as * and added files as +
export GIT_PS1_SHOWDIRTYSTATE=1
# prompt definition
export PS1='\! \[${WHITE}\](\[${YELLOW}\]\u@\h\[${WHITE}\]) \[${RED}\]\w\[${MAGENTA}\] $(__git_ps1 "(%s)") \[${GREEN}\]\$\[${NORMAL}\] '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
    xterm*|rxvt*)
        PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'

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

export LS_COLORS="no=00:fi=00:di=36;40:ln=00;36:pi=40;33:so=00;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=00;32:*.cmd=00;32:*.exe=00;32:*.com=00;32:*.btm=00;32:*.bat=00;32:*.sh=00;32:*.csh=00;32:*.tar=00;31:*.tgz=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.zip=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.bz2=00;31:*.bz=00;31:*.tz=00;31:*.rpm=00;31:*.cpio=00;31:*.jpg=00;35:*.gif=00;35:*.bmp=00;35:*.xbm=00;35:*.xpm=00;35:*.png=00;35:*.tif=00;35:"
export CLICOLOR=1
export LSCOLORS=exfxcxdxbxexexabagacad

alias sync_widget='while [ true ]; do find . -name '*.jsp' -mtime -2s -print -exec cp {} /opt/aos/publication/ROOT/{} \; ; sleep 1; done'
function send_notification {
    MESSAGE=$1
    terminal-notifier -message "$MESSAGE" -title "Bash notification"
}

function mci {
    mvn clean package $* && send_notification "`pwd` clean package $* done"
}

function mcp {
    mvn clean install $* && send_notification "`pwd` clean install $* done"
}

# autojump
[[ -s `brew --prefix`/etc/autojump.bash ]] && source `brew --prefix`/etc/autojump.bash

# git completion
[[ -s /usr/share/git-core/git-completion.bash ]] && source /usr/share/git-core/git-completion.bash

