#!/bin/zsh
# ${XDG_CONFIG_HOME}/zsh/func.zsh
# ZSH functions 

killmc() {
    mcpid=$(ps aux | grep minecraft | tr ' ' '\n' | head -2 | tail -1)
    if [ -n "$mcpid" ]; then
        kill $mcpid
        echo "Killed process with PID $mcpid"
    else
        echo "No suitable process found"
    fi
}

bones(){
    sleep 3s
    xdotool mousedown 3
}

up() {
    for i in `seq $1`; do
        cd ..
    done
}

todo() {
    # Prints a colorized todo list
    filename=$HOME/TODO.txt

    # Use `$ tput <cmd>` to generate escape sequences
    #
    #   <cmd>    Description
    #   -----    -----------
    #   setab    set background color
    #   setaf    set foreground color
    #   bold     make text bold
    #   smso     start bold text
    #   rmso     stop bold text
    #   sgr0     reset text styling
    #   smul     start underlining
    #   rmul     stop underlining
    #
    # Use `$ infocmp alacritty` to check valid tput commands for alacritty
    # Use `$ colors256` script to check colors
    orange="$(tput setaf 208)"
    green="$(tput setaf 118)"
    pink="$(tput setaf 201)"
    reset="$(tput sgr0)"

    # Colorizes each of the (0x??) TODO numbers at the start of a line
    colorized_todos="$(sed "s/^  \((0x\w\+)\)/  $pink\1$green/g" $filename)"

    echo -e "$orange"
    echo -e "   ▄▄▄▄▄          ·▄▄▄▄        .▄▄ · "
    echo -e "   •██  ▪         ██▪ ██ ▪     ▐█ ▀. "
    echo -e "    ▐█.▪ ▄█▀▄     ▐█· ▐█▌ ▄█▀▄ ▄▀▀▀█▄"
    echo -e "    ▐█▌·▐█▌.▐▌    ██. ██ ▐█▌.▐▌▐█▄▪▐█"
    echo -e "    ▀▀▀  ▀█▄▀▪    ▀▀▀▀▀•  ▀█▄▀▪ ▀▀▀▀ "
    echo -e "$reset"
    echo -e "$colorized_todos$reset\n" # note: must add back the newline
}
