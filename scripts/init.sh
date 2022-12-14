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
export reset='\e[0m' #&& echo -e "${reset}Normal text"

# Bold text
export bold='\e[1m' #&& echo -e "${bold}Bold text ${reset}"

# Red
export red='\e[31m'   #&& echo -e "${red}Red ${reset}"
export redbg='\e[41m' #&& echo -e "${redbg}Red background $reset"

# Green
export green='\e[32m'   #&& echo -e "${green}Green ${reset}"
export greenbg='\e[42m' #&& echo -e "${greenbg}Green background ${reset}"

# Yellow
export yellow='\e[33m'   #&& echo -e "${yellow}Yellow ${reset}"
export yellowbg='\e[43m' #&& echo -e "${yellowbg}Yellow background ${reset}"

# Blue
export blue='\e[34m'   #&& echo -e "${blue}Blue ${reset}"
export bluebg='\e[44m' #&& echo -e "${bluebg}Blue background ${reset}"

# Purple
export purple='\e[35m'   #&& echo -e "${purple}Purple ${reset}"
export purplebg='\e[45m' #&& echo -e "${purplebg}Purple background ${reset}"

# Cyan
export cyan='\e[36m'   #&& echo -e "${cyan}Cyan ${reset}"
export cyanbg='\e[46m' #&& echo -e "${cyanbg}Cyan background ${reset}"

echo -e "${cyan}- Done setting colors -${reset}"

# --- Store user's current dir as a var ---

thisDir=$(pwd)

echo -e "${purple}${bold}Current directory: ${reset}$thisDir"

# --- Finish up ---
echo -e "${green}${bold}--- Done initalizing. ---${reset} \n"
