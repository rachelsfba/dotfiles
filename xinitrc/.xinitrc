#!/bin/bash
userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap
i3location=$HOME/.config/i3

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

# Turn off DPMS 
# Turn off system bell
#xset -dpms -b &

# Run password manager
keepassxc &

# Make Ctrl + Alt + Backspace kill X11
setxkbmap -option terminate:ctrl_alt_bksp &

#xmodshit &

if [ "$HOST" = "yemen" ]; then
    xrandr --output eDP-1 --mode 1920x1080
fi

# Generate local host-specific i3 config file and then run i3 wm.
$i3location/bin/gen-local-config && exec i3
