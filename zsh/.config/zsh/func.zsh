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

extract() {
    local c e i

    (($#)) || return

    for i; do
        c=''
        e=1

        if [[ ! -r $i ]]; then
            echo "$0: file is unreadable: \`$i'" >&2
            continue
        fi

        case $i in
        *.t@(gz|lz|xz|b@(2|z?(2))|a@(z|r?(.@(Z|bz?(2)|gz|lzma|xz)))))
               c='bsdtar xvf';;
        *.7z)  c='7z x';;
        *.Z)   c='uncompress';;
        *.bz2) c='bunzip2';;
        *.exe) c='cabextract';;
        *.gz)  c='gunzip';;
        *.rar) c='unrar x';;
        *.xz)  c='unxz';;
        *.zip) c='unzip';;
        *)     echo "$0: unrecognized file extension: \`$i'" >&2
               continue;;
        esac

        command $c "$i"
        e=$?
    done

    return $e
}

