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
