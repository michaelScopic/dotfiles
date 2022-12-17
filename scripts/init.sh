#!/bin/bash

# * Initalizer script

echo -e "--- Initalizing... ---"

# --- Define a countdown function ---
## Currently unused :|
function countdown() {
    seconds="$*"
    start="$(($(date +%s) + seconds))"
    while [ "$start" -ge "$(date +%s)" ]; do
        time="$((start - $(date +%s)))"
        printf '%s\r' "$(date -u -d "@$time" +%S) seconds left... (Press [ctrl+c] to abort)"
    done
}

# --- Set colors ---
echo -e "- Setting colors... - "
# Normal text
export reset='\e[0m'

# Bold text
export bold='\e[1m'

# Red
export red='\e[31m'
export redbg='\e[41m'

# Green
export green='\e[32m'
export greenbg='\e[42m'

# Yellow
export yellow='\e[33m'
export yellowbg='\e[43m'

# Blue
export blue='\e[34m'
export bluebg='\e[44m'

# Purple
export purple='\e[35m'
export purplebg='\e[45m'

# Cyan
export cyan='\e[36m'
export cyanbg='\e[46m'

echo -e "${cyan}- Done setting colors -${reset}"

# --- Store user's current dir as a var ---

thisDir=$(pwd)

echo -e "${purple}${bold}Current directory: ${reset}$thisDir"

# --- Finish up ---
echo -e "${green}${bold}--- Done initalizing. ---${reset} \n"
