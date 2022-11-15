#!/bin/bash

# * Initalizer script

echo -e " 
+-----------------------+
| Initalizing script... |
+-----------------------+ \n"
sleep 0.3


# --- Set colors ---
echo -e " --- Setting colors ---"
# Normal text
reset='\e[0m' && echo -e "${reset}Normal text"

# Bold text
bold='\e[1m' && echo -e "${bold}Bold text ${reset}"

# Red 
red='\e[31m' && echo -e "${red}Red ${reset}"; \
    redbg='\e[41m' && echo -e "${redbg}Red background $reset"

# Green
green='\e[32m' && echo -e "${green}Green ${reset}"; \
    greenbg='\e[42m' && echo -e "${greenbg}Green background ${reset}"
    
# Yellow
yellow='\e[33m' && echo -e "${yellow}Yellow ${reset}"; \
    yellowbg='\e[43m' && echo -e "${yellowbg}Yellow background ${reset}"

# Blue
blue='\e[34m' && echo -e "${blue}Blue ${reset}"; \
    bluebg='\e[44m' && echo -e "${bluebg}Blue background ${reset}"

# Purple
purple='\e[35m' && echo -e "${purple}Purple ${reset}"; \
    purplebg='\e[45m' && echo -e "${purplebg}Purple background ${reset}"
    
# Cyan
cyan='\e[36m' && echo -e "${cyan}Cyan ${reset}"; \
    cyanbg='\e[46m' && echo -e "${cyanbg}Cyan background ${reset}"

sleep 0.3

echo -e "
+----------------------+
| ${green}Done setting colors! ${reset}|
+----------------------+ \n"

sleep 0.5

# --- Print out basic info ---
echo -e "${bold}---------- Basic info ----------${reset}"
# Print the distro 
echo -e "${green}${bold}Distro:${reset} $(lsb_release -d | cut -f 2- )"
# Print kernel version
echo -e "${yellow}${bold}Kernel:${reset} $(uname -srm)" 
# Print shell 
echo -e "${blue}${bold}Shell:${reset} $SHELL"
# Print hostname
echo -e "${purple}${bold}Hostname:${reset} $(cat /etc/hostname || uname -n)"
# Print current user (is user root?)
echo -e "${cyan}${bold}User:${reset} $(whoami)"
echo -e "${bold}-------------------------------- \n${reset}"

# --- Store this directory as a variable ---
currentDir=$(pwd)
echo -e "${yellow}${bold}Current directory is:${reset} $currentDir "

echo -e "${green}${bold}Done initalizing. \n${reset}"
