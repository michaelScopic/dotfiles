#!/bin/bash

# * Initalizer script

echo -e " 
+-----------------------+
| Initalizing script... |
+-----------------------+ "
sleep 0.5

currentDir=$(pwd)
echo -e "Current directory: $currentDir"
echo -e ""

# -- Set colors --
echo -e " --- Setting colors... ---"
reset='\e[0m' && echo -e "$reset Normal text"
red='\e[31m' && echo -e "$red Red $reset"; redbg='\e[41m' && echo -e "$redbg Red background $reset"
green='\e[32m' && echo -e "$green Green $reset"; greenbg='\e[42m' && echo -e "$greenbg Green background $reset"
yellow='\e[33m' && echo -e "$yellow Yellow $reset"; yellowbg='\e[43m' && echo -e "$yellowbg Yellow background $reset"
blue='\e[34m' && echo -e "$blue Blue $reset"; bluebg='\e[44m' && echo -e "$bluebg Blue background $reset"
purple='\e[35m' && echo -e "$purple Purple $reset"; purplebg='\e[45m' && echo -e "$purplebg Purple background $reset"
cyan='\e[36m' && echo -e "$cyan Cyan $reset"; cyanbg='\e[46m' && echo -e "$cyanbg Cyan background $reset"
sleep 0.3

echo -e "
+-----------------------+
| $green Done setting colors! $reset|
+-----------------------+"

sleep 0.5
echo -e ""

# --- Print out basic info ---
echo -e "---------- Basic info ----------"
# Print the distro 
echo -e   "$green Distro:$reset $(lsb_release -d | cut -f 2- )"
# Print kernel version
echo -e "$yellow Kernel:$reset $(uname -r) $(uname -m)" 
# Print shell 
echo -e "$blue Shell:$reset $SHELL"
# Print hostname
echo -e "$purple Hostname:$reset $(cat /etc/hostname)"
# Print current user (is user root?)
echo -e "$cyan User:$reset $(whoami)"
echo -e "--------------------------------"
echo ""
echo -e "$greenbg Done. $reset"