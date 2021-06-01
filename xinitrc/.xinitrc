#!/bin/bash
userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap
i3location=$HOME/dotfiles/i3/.config/i3

# merge in defaults and keymaps
if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

if [ "$HOST" = "mongolia" ]; then
    qbittorrent & # seeding is good manners, friends.
    discord & # discord
fi


#xset -dpms b 100 &
xset -dpms -b &
sleepytime &
# xautolock -time 10 -locker lock &
#urxvtd &
nextcloud &
#keepass_wrapper &
keepassxc &
setxkbmap -option      terminate:ctrl_alt_bksp &
xmodshit &
setdisplay

# Generate local host-specific i3 config file and then run i3 wm.
$i3location/bin/gen-local-config && exec i3
