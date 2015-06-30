export PATH=/usr/local/go/bin:/usr/local/bin:/usr/local/git/bin:$PATH:/usr/local/smlnj-110.75/bin:/usr/local/share/python/
export PATH=/usr/local/share/npm/bin:$PATH

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

# git branch name in PS1
[[ -s /usr/local/git/contrib/completion/git-prompt.sh ]] && source /usr/local/git/contrib/completion/git-prompt.sh

# show untracked files as %
export GIT_PS1_SHOWUNTRACKEDFILES=1
# show dirty state as * and added files as +
export GIT_PS1_SHOWDIRTYSTATE=1
# prompt definition
export PS1='\! \[${WHITE}\](\[${YELLOW}\]\u@\h\[${WHITE}\]) \[${RED}\]\w\[${MAGENTA}\] $(__git_ps1 "(%s)") \[${GREEN}\]\$\[${NORMAL}\] '
# export PS1='\! \[${WHITE}\](\[${YELLOW}\]\u@\h\[${WHITE}\]) \[${RED}\]\W\[${MAGENTA}\]\[${GREEN}\]\$\[${NORMAL}\] '

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
    mvn clean install $* && send_notification "`pwd` clean install $* done"
}

function mcp {
    mvn clean package $* && send_notification "`pwd` clean package $* done"
}

function o {
    COMMAND=$*
    $COMMAND && send_notification "'$COMMAND' done" || send_notification "'$COMMAND' not successful'"
}

# autojump
[[ -s `brew --prefix`/etc/autojump.sh ]] && source `brew --prefix`/etc/autojump.sh

# git completion
[[ -s /usr/local/git/contrib/completion/git-completion.bash ]] && source /usr/local/git/contrib/completion/git-completion.bash

# brew completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

[[ -s $HOME/Dotfiles/bash.completion.d ]] && source $HOME/Dotfiles/bash.completion.d/*

[[ -s $HOME/.bashrc.local ]] && source $HOME/.bashrc.local

[[ "$(which hub)" ]] && eval "$(hub alias -s)"

# added by travis gem
[ -f /Users/kubek2k/.travis/travis.sh ] && source /Users/kubek2k/.travis/travis.sh
