export PATH=/usr/local/go/bin:/usr/local/bin:/usr/local/git/bin:$PATH:/usr/local/smlnj-110.75/bin:/usr/local/share/python:${HOME}/Dotfiles/scripts
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

# prompt definition
ORIGINAL_PS1='\[${RED}\]\w\[${MAGENTA}\] $(__git_ps1 "(%s)") \[${GREEN}\]\$\[${NORMAL}\] '
#export PS1='\! ${WHITE}(${YELLOW}\u@\h${WHITE}) ${RED}\w${MAGENTA}${GREEN} \$${NORMAL} '
export PROMPT_COMMAND='PS1="\n`soji header`\n\[${NORMAL}\]\[${CYAN}\]`soji status`: ${ORIGINAL_PS1}"'

export LS_COLORS="no=00:fi=00:di=36;40:ln=00;36:pi=40;33:so=00;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=00;32:*.cmd=00;32:*.exe=00;32:*.com=00;32:*.btm=00;32:*.bat=00;32:*.sh=00;32:*.csh=00;32:*.tar=00;31:*.tgz=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.zip=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.bz2=00;31:*.bz=00;31:*.tz=00;31:*.rpm=00;31:*.cpio=00;31:*.jpg=00;35:*.gif=00;35:*.bmp=00;35:*.xbm=00;35:*.xpm=00;35:*.png=00;35:*.tif=00;35:"
export CLICOLOR=1
export LSCOLORS=exfxcxdxbxexexabagacad

export EDITOR=nvim
alias v=nvim
alias s=soji
alias ls='ls --color'

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

# brew completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

# nix completions
for f in /run/current-system/sw/share/bash-completion/completions/*; do
    . $f
done
for f in /run/current-system/sw/etc/bash_completion.d/*; do
    . $f
done

[[ -s $HOME/.bashrc.local ]] && source $HOME/.bashrc.local

# added by travis gem
[ -f /Users/kubek2k/.travis/travis.sh ] && source /Users/kubek2k/.travis/travis.sh

export NVM_DIR="/Users/kubek2k/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

for f in ~/Dotfiles/bash/*; do
    [ -f "$f" ] && source "$f"
done
