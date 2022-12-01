#!/bin/bash

#* Script to print basic info about the machine it's running on 
#* Needs `init.sh` for color functionality

# --- Print out basic info ---
echo -e "${bold}---------- Basic info ----------${reset}"
# Print the distro
echo -e "${green}${bold}Distro:${reset} $(lsb_release -d | cut -f 2-)"
# Print kernel version
echo -e "${yellow}${bold}Kernel:${reset} $(uname -srm)"
# Print shell
echo -e "${blue}${bold}Shell:${reset} $SHELL"
# Print hostname
echo -e "${purple}${bold}Hostname:${reset} $(cat /etc/hostname 2>/dev/null || uname -n)"
# Print CPU name
echo -e "${red}${bold}CPU:${reset} $(lscpu | grep "Model name:" | sed -r 's/Model name:\s{1,}//g')"
# Print current user
echo -e "${cyan}${bold}User:${reset} $(whoami)"
echo -e "${bold}-------------------------------- \n${reset}"

sleep 2

