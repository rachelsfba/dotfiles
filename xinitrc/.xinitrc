#!/bin/bash
userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap
i3location=$HOME/dotfiles/i3/.i3

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
    xrandr --output DVI-I-1 --mode 1920x1080 --output DP-1.1.8 --primary --right-of DVI-I-1 --mode 1920x1080 --output DP-1.8 --right-of DP-1.1.8 --mode 1920x1080
elif [ "$HOST" = "yemen" ]; then
    xrandr --auto
fi


#xset -dpms b 100 &
xset -dpms -b &
xmodshit &
sleepytime &
# xautolock -time 10 -locker lock &
urxvtd &
qbittorent %
nextcloud &
keepass &
discord &


# Generate local host-specific i3 config file and then run i3 wm.
$i3location/bin/gen-local-config && exec i3
