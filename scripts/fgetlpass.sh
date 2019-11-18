#!/usr/bin/env bash

function ensureLoggedIn() {
    lpass status 2>&1 > /dev/null
    if [ $? -ne 0 ]; then
        exit 1
    fi
}

ensureLoggedIn
lpass ls -u -l | 
    fzf --preview "echo {} | 
        sed -e 's/[^\[]*\[id: \([0-9]*\)\].*/\1/' | 
        xargs lpass show --json |
        jq '.[0] | { username: .username, name: .name, url: .url }'" | 
    sed -e 's/[^\[]*\[id: \([0-9]*\)\].*/\1/'  | 
    xargs lpass show --password
