#!/bin/zsh
# ${XDG_CONFIG_HOME}/zsh/export.zsh
# ZSH global variables

# File hierarchy...
export DATA=/data
export D_CODE=$DATA/Code
export D_WEB=$D_WWW
export D_MEDIA=$DATA/Media
export D_GAMES=$DATA/Games
export D_MUSIC=$D_MEDIA/Music

if [ "$HOST" = "yemen" ]; then
    export D_DOC=$DATA
elif [ "$HOST" = "mongolia" ]; then
    export D_DOC=$DATA/Documents
fi

#export D_DBOX=$D_DOC/Dropbox
export D_NCLOUD=$D_DOC/NextCloud

export D_DL=$D_DOC/Downloads
export D_FL=/media/fl

export D_DROID=$DATA/Droid
export D_DROIDROOT=$DATA/Droid/sdcard0

export D_DND=$D_NCLOUD/DnD
export D_ART=$D_NCLOUD/Art
export D_VIDS=$D_NCLOUD/Videos
export D_VIDEOS=$D_VIDS
export D_PHOTOS=$D_NCLOUD/Photographs
export D_PHOTOGRAPHS=$D_PHOTOS
export D_MEMES=$D_NCLOUD/Memes

export D_RCC=$D_NCLOUD/RCC_Classes
export D_PHY=$D_RCC/PHY
export D_PHY232=$D_RCC/PHY/232
export D_PHY242=$D_RCC/PHY/242

export D_UVA=$D_NCLOUD/UVA
export D_CS=$D_UVA/CS
export D_ECE=$D_UVA/ECE
export D_APMA=$D_UVA/APMA
export D_STS=$D_UVA/STS

# XDG settings
export XDG_CACHE_HOME=~/.cache
export XDG_CONFIG_HOME=~/.config
export XDG_DATA_HOME=$HOME/.local/share

# Commonly-used dir shortcuts
export BINARIES=~/bin
#export MC=$HOME/.minecraft
export MC=$D_GAMES/Minecraft
export CODE=$D_CODE
export DL=$D_DL
export DEV_DIR=$HOME/dev

# Environmental variables
export EDITOR=nvi
export TERMINAL=alacritty
export PATH=$BINARIES:$(ruby -e 'print Gem.user_dir')/bin:$PATH
export PYTHONPATH=~/dev:$PYTHONPATH

# MPD stuff
export MPD_PASS=$(cat ${XDG_DATA_HOME}/mpd/password)
export MPD_HOST=${MPD_PASS}@10.0.0.251

# Qt4/Qt5/KDE/GTK theme stuff
export QT_QPA_PLATFORMTHEME=qt5ct

# ZSH config
export TZ='America/New_York'
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

