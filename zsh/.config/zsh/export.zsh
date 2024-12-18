#!/bin/zsh
# ${XDG_CONFIG_HOME}/zsh/export.zsh
# ZSH global variables

# File hierarchy...
export DATA=/data
export D_CODE=$DATA/Code
export D_WEB=$D_WWW
export D_MEDIA=$DATA/Media
export D_GAMES=$DATA/Games
export D_BACKUPS=$DATA/Backups
export D_MUSIC=$D_MEDIA/Music

if [ "$HOST" = "sjc-laptop" ]; then
    export D_DOC=$DATA
elif [ "$HOST" = "sjc-pc" ]; then
    export D_DOC=$DATA/Documents
fi

export D_NCLOUD=$D_DOC/NextCloud
export D_DL=$D_DOC/Downloads
export D_ALY=$D_NCLOUD/Aly
export D_RECIPES=$D_DOC/Notion/Recipes
export D_ART=$D_NCLOUD/Art
export D_VIDS=$D_NCLOUD/Videos
export D_VIDEOS=$D_VIDS
export D_PHOTOS=$D_NCLOUD/Photographs

# XDG settings
export XDG_CACHE_HOME=$HOME/.cache
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share

# Commonly-used dir shortcuts
export BINARIES=~/bin
#export MC=$HOME/.minecraft
export MC=$D_GAMES/Minecraft
export CODE=$D_CODE
export DL=$D_DL
export DEV_DIR=$HOME/dev

# Rust config variables
# N.B. $CARGO_HOME/env will be sourced in .zshrc
export RUSTUP_HOME=$XDG_DATA_HOME/rustup
export CARGO_HOME=$XDG_CACHE_HOME/cargo

# General environment variables
export EDITOR=nvim
export SYSTEMD_EDITOR=nvim
export TERMINAL=alacritty
export PATH=$BINARIES:$PATH
#export PYTHONPATH=$PYTHONPATH

# MPD stuff
export MPD_HOST=$XDG_RUNTIME_DIR/mpd/socket

# Qt4/Qt5/KDE/GTK theme stuff
export QT_QPA_PLATFORMTHEME=qt5ct

# ZSH config
export HISTFILE=~/.zshhistory
export HISTSIZE=5000
export SAVEHIST=1000000

# Ansible
export ANSIBLE_CONFIG=$XDG_CONFIG_HOME/ansible/ansible.cfg

# per https://dev.to/iggredible/how-to-search-faster-in-vim-with-fzf-vim-36ko
if type rg &> /dev/null; then
    export FZF_DEFAULT_COMMAND='rg --files --hidden'
    export FZF_DEFAULT_OPTS='-m --height 50% --border'
fi

