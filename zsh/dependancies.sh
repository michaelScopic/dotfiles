#!/bin/bash

# * Script to install dependancies according to user's distro/package manager
# * REQUIRED BY: pluginInstall.sh

# TODO: literally everything

# --- Set colors ---
# - not sourcing init.sh just for colors, bc it's dumb. I will manually set colors here -
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
    # If $distroID isn't empty, then prefer $distroID
    distro=$distroID
    echo $distro
fi

# --- Distro functions ---
debian() {
    # If $distro == debian, then run this function
    echo -e "${red}${bold}Detected Debian/Ubuntu.${reset}"
    sudo apt-get install -y git kitty neofetch zsh curl wget htop fzf exa
    # Installing lsd
    mkdir .tmp ; cd .tmp
    wget https://github.com/Peltoche/lsd/releases/download/0.23.1/lsd_0.23.1_amd64.deb && \
    sudo dpkg sudo dpkg -i lsd_0.23.1_amd64.deb && \
    cd .. ; rm -rf .tmp/ 
    echo -e "${greenbg}Done installing dependancies!"
}

arch_linux() {
    # If $distro == arch, then run this function
    echo -e "${red}${bold}Detected Arch Linux.${reset}"
    sudo pacman -Sy --noconfirm starship kitty neofetch zsh curl wget git htop fzf exa lsd 
    echo -e "${greenbg}Done installing dependancies!${reset}"
}

rpm_based() {
    # If $distro is rpm based, then run this function
    echo -e "${red}${bold}Detected an RPM based distro.${reset}"
    sudo dnf install -y neovim kitty neofetch zsh curl wget git fzf exa lsd || \
        sudo yum install neovim kitty neofetch zsh curl wget git fzf exa lsd 
    echo -e "${greenbg}Done installing dependancies!${reset}"
}

opensuse() {
    # If $distro == openSUSE, then run this function
    echo -e "${red}${bold}Detected openSUSE.${reset}"
    sudo zypper install -n neovim kitty neofetch zsh curl wget git fzf exa lsd 
    echo -e "${greenbg}Done installing dependancies!${reset}"
}

void() {
    # If $distro == Void Linux, then run this function
    echo -e "${red}${bold}Detected Void Linux.${reset}"
    sudo xbps-install -Sy neovim kitty neofetch zsh curl wget git fzf exa lsd 
    echo -e "${greenbg}Done installing dependancies!${reset}"
}


# --- Run above functions according to $distro ---

if [ "$distro" == "^debian" ]; then
    echo "$distro -> debian "
    debian() 
elif [ "$distro" == "^arch" ]; then
    echo "$distro -> arch"
    arch_linux()
elif [ "$distro" == "^fedora" ] || [ "$distro" == "^centos" ] || [ "$distro" == "^rhel" ]; then
    echo "$distro -> rpm_based"
    rpm_based()
elif [ "$distro" == "^opensuse" ]; then
    echo "$distro -> opensuse"
    opensuse()
elif [ "$distro" == "^void" ]; then
    echo "$distro -> void"
    void()
fi
