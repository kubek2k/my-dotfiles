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

export PS1="\n\! \[${WHITE}\](\[${YELLOW}\]\u@\h\[${WHITE}\]) \[${RED}\]\w\[${GREEN}\] \$\[${NORMAL}\] "

export LS_COLORS="no=00:fi=00:di=36;40:ln=00;36:pi=40;33:so=00;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=00;32:*.cmd=00;32:*.exe=00;32:*.com=00;32:*.btm=00;32:*.bat=00;32:*.sh=00;32:*.csh=00;32:*.tar=00;31:*.tgz=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.zip=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.bz2=00;31:*.bz=00;31:*.tz=00;31:*.rpm=00;31:*.cpio=00;31:*.jpg=00;35:*.gif=00;35:*.bmp=00;35:*.xbm=00;35:*.xpm=00;35:*.png=00;35:*.tif=00;35:"
export CLICOLOR=1
export LSCOLORS=exfxcxdxbxexexabagacad

[[ -s /usr/local/Cellar/autojump/20/etc/autojump.bash ]] && source /usr/local/Cellar/autojump/20/etc/autojump.bash

alias sync_widget='while [ true ]; do find . -name '*.jsp' -mtime -2s -print -exec cp {} /opt/aos/publication/ROOT/{} \; ; sleep 1; done'
