#!/usr/bin/env python3
#
# github.com/justbuchanan/i3scripts
#
# This script listens for i3 events and updates workspace names to show icons
# for running programs.  It contains icons for a few programs, but more can
# easily be added by editing the WINDOW_ICONS list below.
#
# It also re-numbers workspaces in ascending order with one skipped number
# between monitors (leaving a gap for a new workspace to be created). By
# default, i3 workspace numbers are sticky, so they quickly get out of order.
#
# Dependencies
# * xorg-xprop  - install through system package manager
# * i3ipc       - install with pip
# * fontawesome - install with pip
#
# Installation:
# * Download this repo and place it in ~/.config/i3/ (or anywhere you want)
# * Add "exec_always ~/.config/i3/i3scripts/autoname_workspaces.py &" to your i3 config
# * Restart i3: $ i3-msg restart
#
# Configuration:
# The default i3 config's keybindings reference workspaces by name, which is an
# issue when using this script because the "names" are constantly changing to
# include window icons.  Instead, you'll need to change the keybindings to
# reference workspaces by number.  Change lines like:
#   bindsym $mod+1 workspace 1
# To:
#   bindsym $mod+1 workspace number 1

import i3ipc
import logging
import signal
import sys
import fontawesome as fa

from util import *

# Add icons here for common programs you use.  The keys are the X window class
# (WM_CLASS) names (lower-cased) and the icons can be any text you want to
# display.
#
# Most of these are character codes for font awesome:
#   http://fortawesome.github.io/Font-Awesome/icons/
#
# If you're not sure what the WM_CLASS is for your application, you can use
# xprop (https://linux.die.net/man/1/xprop). Run `xprop | grep WM_CLASS`
# then click on the application you want to inspect.
WINDOW_ICONS = {
    'alacritty': fa.icons['terminal'],
    'atom': fa.icons['code'],
    'ario': fa.icons['play'],
    'banshee': fa.icons['play'],
    'boostnote': fa.icons['pencil-alt'],
    'cura': fa.icons['cube'],
    'darktable': fa.icons['image'],
    'discord': fa.icons['discord'],
    'evince': fa.icons['file-pdf'],
    'evolution': fa.icons['envelope'],
    'feh': fa.icons['image'],
    'firefox': fa.icons['firefox'],
    'foxitreader': fa.icons['file-pdf'],
    'gedit': fa.icons['file-alt'],
    'gimp': fa.icons['camera-retro'],
    'google play music desktop player': fa.icons['compact-disc'],
    'google-chrome': fa.icons['chrome'],
    'googleearth': fa.icons['globe'],
    'googleearth-bin': fa.icons['globe'],
    'gpick': fa.icons['eye-dropper'],
    'gpicview': fa.icons['image'],
    'gpmpd': fa.icons['compact-disc'],
    'imv': fa.icons['image'],
    'keybase': fa.icons['key'],
    'kicad': fa.icons['microchip'],
    'kitty': fa.icons['terminal'],
    'libreoffice': fa.icons['file-alt'],
    'libreoffice-writer': fa.icons['file-alt'],
    'libreoffice-calc': fa.icons['file-invoice-dollar'],
    'lutris': fa.icons['gamepad'],
    'minecraft': fa.icons['globe'],
    'mpv': fa.icons['tv'],
    'mupdf': fa.icons['file-pdf'],
    'nautilus': fa.icons['folder'],
    'nextcloud': fa.icons['cloud'],
    'openscad': fa.icons['cube'],
    'org.gnome.gedit': fa.icons['file-alt'],
    'pavucontrol': fa.icons['compact-disc'],
    'postman': fa.icons['space-shuttle'],
    'qbittorrent': fa.icons['download'],
    'quakelive_steam.exe': fa.icons['gamepad'],
    'slack': fa.icons['slack'],
    'spotify': fa.icons['spotify'],  # could also use the 'spotify' icon
    'steam': fa.icons['steam'],
    'subl': fa.icons['file-alt'],
    'subl3': fa.icons['file-alt'],
    'thunar': fa.icons['copy'],
    'Tor Browser': fa.icons['theater-masks'],
    'sublime_text': fa.icons['file-alt'],
    'thunderbird': fa.icons['envelope'],
    'urxvt': fa.icons['terminal'],
    'vlc': fa.icons['tv'],
    'VirtualBox Manager': fa.icons['server'],
    'VirtualBox Machine': fa.icons['desktop'],
    'VirtualBox': fa.icons['server'],
    'wine': fa.icons['windows'],
    'xfce4-terminal': fa.icons['terminal'],
    'zathura': fa.icons['file-pdf'],
    'zenity': fa.icons['window-maximize'],
}

# This icon is used for any application not in the list above
DEFAULT_ICON = '*'


def ensure_window_icons_lowercase():
    for cls in WINDOW_ICONS:
        if cls != cls.lower():
            WINDOW_ICONS[cls.lower()] = WINDOW_ICONS[cls]
            del WINDOW_ICONS[cls]


def icon_for_window(window):
    # Try all window classes and use the first one we have an icon for
    classes = xprop(window.window, 'WM_CLASS')
    if classes != None and len(classes) > 0:
        for cls in classes:
            cls = cls.lower()  # case-insensitive matching
            if cls in WINDOW_ICONS:
                return WINDOW_ICONS[cls]
    logging.info(
        'No icon available for window with classes: %s' % str(classes))
    return DEFAULT_ICON


# renames all workspaces based on the windows present
# NOTE: I removed the renumbering aspect since I don't like it.
def rename_workspaces(i3):
    ws_infos = i3.get_workspaces()

    for ws_index, workspace in enumerate(i3.get_tree().workspaces()):
        ws_info = ws_infos[ws_index]

        name_parts = parse_workspace_name(workspace.name)
        new_icons = ' '.join([icon_for_window(w) for w in workspace.leaves()])

        new_name = construct_workspace_name(
            NameParts(
                num=ws_info['num'], shortname=name_parts.shortname, icons=new_icons))
        if workspace.name == new_name:
            continue
        i3.command(
            'rename workspace "%s" to "%s"' % (workspace.name, new_name))


# Rename workspaces to just numbers and shortnames, removing the icons.
def on_exit(i3):
    for workspace in i3.get_tree().workspaces():
        name_parts = parse_workspace_name(workspace.name)
        new_name = construct_workspace_name(
            NameParts(
                num=name_parts.num, shortname=name_parts.shortname,
                icons=None))
        if workspace.name == new_name:
            continue
        i3.command(
            'rename workspace "%s" to "%s"' % (workspace.name, new_name))
    i3.main_quit()
    sys.exit(0)


if __name__ == '__main__':
    logging.basicConfig(level=logging.INFO)

    ensure_window_icons_lowercase()

    i3 = i3ipc.Connection()

    # Exit gracefully when ctrl+c is pressed
    for sig in [signal.SIGINT, signal.SIGTERM]:
        signal.signal(sig, lambda signal, frame: on_exit(i3))

    rename_workspaces(i3)

    # Call rename_workspaces() for relevant window events
    def event_handler(i3, e):
        if e.change in ['new', 'close', 'move']:
            rename_workspaces(i3)

    i3.on('window', event_handler)
    i3.on('workspace::move', event_handler)
    i3.main()
