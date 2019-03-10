#!/bin/zsh
# ${XDG_CONFIG_HOME}/zsh/aliases.zsh
# ZSH aliases 

alias ..='cd ..'
alias mkdir='mkdir -p -v'
alias cp='cp -rf'

#alias grep='grep --color=auto'
alias grep="/bin/grep $GREP_OPTIONS"
unset GREP_OPTIONS

alias more='less'

alias spck="aspell -t -c"
alias rgrep="grep -r"

alias cd1="cd ${D_UVA} && exa -laF"
alias cd2='cd $DL && exa -laF -sold'

alias ls='ls++ -al'
alias lsp='ls++ --potsf'
#alias ls='exa -laF --git'

alias urxvt='urxvt -name mongolia'
alias gp='git push'
alias ga='git add'
alias gc='git commit'
alias sta='git status'
alias gs='sta'
alias wim='vim -p --servername azerbaijan'
alias vim='wim'

alias dps='docker ps -a'
alias dex='docker exec -it www /bin/bash'
alias dsql='docker exec -it db_adm /bin/bash'

alias inc="chromium --incognito"

# From https://askubuntu.com/a/104484
alias ppt2pdf="libreoffice --headless --invisible --convert-to pdf" 

# Used for projecting to other monitors
alias project='xrandr --output HDMI1 --mode 1920x1080 --left-of eDP1'
alias unproject='xrandr --output HDMI1 --off'

alias identwin='xprop | grep WM_CLASS'
alias tea='termdown 2m -b'
alias tea2='termdown 4m -b'
