# Store zsh files in XDG_CONFIG_HOME 
export ZSH_HOME=$HOME/.config/zsh
# Set path to starship config
export STARSHIP_CONFIG=$XDG_CONFIG_HOME/starship/starship.toml

# Source custom ZSH config stored in other files
source $ZSH_HOME/aliases.zsh
source $ZSH_HOME/export.zsh
source $ZSH_HOME/func.zsh
# source $ZSH_HOME/zsh-syntax-highlighting-filetypes.zsh

# Source virtualenvwrapper settings
#source $ZSH_HOME/virtualenvwrapper.zsh

setopt extended_history
setopt share_history
function history_all { history -E 1 }

setopt notify globdots pushdtohome cdablevars autolist
setopt autocd recexact longlistjobs
setopt autoresume pushdsilent
setopt autopushd pushdminus extendedglob rcquotes mailwarning
unsetopt bgnice autoparamslash 
unsetopt BEEP # Per https://blog.vghaisas.com/zsh-beep-sound/
autoload -Uz compinit
compinit

# smart urls
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

# tabcomplete to files as well
compdef _files mkdir

zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path $XDG_CACHE_HOME/zsh_$HOST
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:processes' command 'ps -axw'
zstyle ':completion:*:processes-names' command 'ps -awxho command'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*:scp:*' tag-order \
zstyle ':completion:*:scp:*' group-order \
zstyle ':completion:*:ssh:*' tag-order \
zstyle ':completion:*:ssh:*' group-order \

# For help, see zshzle(1) man page ("ZSH Line Editor")
bindkey -v  # use `viins` keymap
bindkey "^a" beginning-of-line      # See https://stackoverflow.com/questions/23128353/zsh-shortcut-ctrl-a-not-working
bindkey "\e[H" beginning-of-line
bindkey "\e[1~" beginning-of-line

bindkey "^e" end-of-line            # See https://stackoverflow.com/questions/23128353/zsh-shortcut-ctrl-a-not-working
bindkey "\e[F" end-of-line
bindkey "\e[4~" end-of-line

bindkey "\e[2~" quoted-insert
bindkey "\e[3~" delete-char
bindkey "\e[5~" beginning-of-history
bindkey "\e[6~" end-of-history
bindkey "\e[5C" forward-word
bindkey "\e[5D" backward-word
bindkey '^i' expand-or-complete-prefix # Completion in the middle of a line
bindkey '^z' undo                      # C-x-u is overkill
bindkey "^r" history-incremental-pattern-search-backward
bindkey "^f" history-incremental-pattern-search-forward
bindkey '^w' kill-word
bindkey '^b' backward-kill-word
bindkey ' ' magic-space                # Do history expansion on space

# Set LS_COLORS
if [ -f ${XDG_CONFIG_HOME}/LS_COLORS ]; then
    eval `dircolors -b ${XDG_CONFIG_HOME}/LS_COLORS`
fi

# Source rustup env (adds Rust binaries to $PATH)
if [ -f ${CARGO_HOME}/env ]; then
    source ${CARGO_HOME}/env
fi

# Load SSH key into memory so I'm not prompted for my password all the time
# if [ -f ~/.ssh/id_ecdsa ]; then
#     eval `keychain -q --eval ~/.ssh/id_ecdsa`
# fi
if [ -f ~/.ssh/id_ed25519 ]; then
    eval `keychain -q --eval ~/.ssh/id_ed25519`
fi

# Show TODO list
# todo

eval "$(starship init zsh)"
