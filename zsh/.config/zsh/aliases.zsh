#!/bin/zsh
# ${XDG_CONFIG_HOME}/zsh/aliases.zsh
# ZSH aliases 
alias scat='bat -pp'  # scat := *s*ource code *cat*
alias vim='vim -p'
alias ..='cd ..'
alias mkdir='mkdir -p -v'
alias cp='cp -rf'

#alias grep='grep --color=auto'
alias grep="/bin/grep $GREP_OPTIONS"
unset GREP_OPTIONS

alias more='less'

alias spck="aspell -t -c"
alias rgrep="grep -r"

alias cd2='cd $DL && exa -laF -snew'

# {{{ ls-related
alias ls='lsd'
alias l='lsd'
alias la='lsd -a'
alias ll='lsd -al'
#alias lsp='ls++ --potsf'
#alias ls='exa -laeF --git'
# }}}

# {{{ git-related
alias ga='git add'
alias gc='git commit'
alias gcl='git clone'
alias gl='git pull'
alias gp='git push' 
# }}}

# From https://askubuntu.com/a/104484
alias ppt2pdf="libreoffice --headless --invisible --convert-to pdf" 

# Used for projecting to other monitors
alias project='xrandr --output HDMI1 --mode 1920x1080 --left-of eDP1'
alias unproject='xrandr --output HDMI1 --off'

alias identwin='xprop | grep WM_CLASS'
alias tea='termdown 2m && ( while true; do paplay $XDG_DATA_HOME/sounds/bell.ogg; done )'
alias tea2='termdown 4m && ( while true; do paplay $XDG_DATA_HOME/sounds/bell.ogg; done )'

# Per https://www.reddit.com/r/archlinux/comments/kcbjcu/discord_becomes_laggy_during_long_voice_calls/
alias discord='discord --no-sandbox'

#alias keepassxc='QT_AUTO_SCREEN_SCALE_FACTOR=0 QT_QPA_PLATFORMTHEME= keepassxc'
