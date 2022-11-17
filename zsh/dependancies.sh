#!/bin/bash

# * Script to install dependancies according to user's distro/package manager
# * REQUIRED BY: pluginInstall.sh

# TODO: literally everything

# --- Set colors ---
# - not sourcing init.sh just for colors, tbc its' dumb. I will manually set colors here -
reset='\e[0m' 
bold='\e[1m' 
red='\e[31m' ; redbg='\e[41m'
green='\e[32m' ; greenbg='\e[42m' 
yellow='\e[33m' ; yellowbg='\e[43m' 
blue='\e[34m' ; bluebg='\e[44m' 
purple='\e[35m' ; purplebg='\e[45m'
cyan='\e[36m' ; cyanbg='\e[46m'

# --- Set current dir as var ---
thisDir=$(pwd)


# --- Find user's distro and store it as a variable ---
distroNAME="$(cat /etc/os-release | grep ^NAME | awk -F'"' '{print $2 }')"
distroID="$(cat /etc/os-release | grep ^ID | awk -F= '{ print $2 }')"
echo "NAME: $distroNAME | ID_LIKE:$distroID"

if [ "$distroID" == "" ]; then
    # If $distroID has nothing, then prefer $distroNAME
    distro=$distroNAME
    echo $distro
else
    # If $distroID isn't empty, then prefer $distroID_LIKE
    distro=$distroID_LIKE
    echo $distro
fi

debian() {
    # If $distro == debian, then run this function
    echo -e "${red}${bold}Detected Debian/Ubuntu.${reset}"

    sudo apt-get install git kitty neofetch zsh curl wget htop fzf exa

    # Installing lsd
    wget https://github.com/Peltoche/lsd/releases/download/0.23.1/lsd_0.23.1_amd64.deb && sudo dpkg sudo dpkg -i lsd_0.23.1_amd64.deb

    echo -e "${greenbg}Done installing dependancies!"
}

