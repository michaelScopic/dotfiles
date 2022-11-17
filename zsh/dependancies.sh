#!/bin/bash

# * Script to install dependancies according to user's distro/package manager
# * USED IN: pluginInstall.sh

# TODO: Test on different distros/derivatives

# --- Set colors ---
# - not sourcing init.sh just for colors bc it's dumb. I will manually set colors here -
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
#distroLIKE="$(cat /etc/os-release | grep ^ID | awk -F= '{ print $2 }')"
distroLIKE="$(cat /etc/os-release | grep ^ID_LIKE | awk -F= '{ print $2 }')"
echo "NAME: $distroNAME | LIKE: $distroLIKE"

if [ "$distroLIKE" == "" ]; then
    # If $distroLIKE has nothing, then prefer $distroNAME
    if [ "$distroNAME" == "Debian GNU/Linux" ]; then
        # If we pick up Debian, then just correct the variable
        distroNAME="debian"
    fi
    distro=$distroNAME
    echo "Using \$distroNAME as \$distro: ($distro)"
else
    # If $distroLIKE isn't empty, then prefer $distroID
    distro=$distroLIKE
    echo "Using \$distroLIKE as \$distro: ($distro)"
fi

# --- Distro functions ---
function debian() {     # Tested on: Ubuntu, Debian (fixed),
    # If $distro == debian, then run this function
    echo -e "${green}${bold}Detected Debian/Ubuntu.${reset}"
    sleep 2
    sudo apt-get install -y git kitty neofetch zsh curl wget htop fzf exa
    # Installing lsd
    mkdir $thisDir/.tmp ; cd $thisDir.tmp
    wget https://github.com/Peltoche/lsd/releases/download/0.23.1/lsd_0.23.1_amd64.deb && \
    sudo dpkg -i lsd_0.23.1_amd64.deb && \
    cd $thisDir ; rm -rfv $thisDir/.tmp/ 
    # Installing starship
    curl -sS https://starship.rs/install.sh | sh
    echo -e "${greenbg}Done installing dependancies!${reset}"
}

function arch_linux() {     # Tested on Arch, Manjaro (only on ID_LIKE),
    # If $distro == arch, then run this function
    echo -e "${green}${bold}Detected Arch Linux.${reset}"
    sleep 2
    sudo pacman -Sy --noconfirm starship kitty neofetch zsh curl wget git htop fzf exa lsd 
    echo -e "${greenbg}Done installing dependancies!${reset}"
}

function rpm_based() {     # - Untested - 
    # If $distro is rpm based, then run this function
    echo -e "${green}${bold}Detected an RPM based distro.${reset}"
    sleep 2
    sudo dnf install -y neovim kitty neofetch zsh curl wget git fzf exa lsd || \
        sudo yum install -y neovim kitty neofetch zsh curl wget git fzf exa lsd 
    # Install starship
    curl -sS https://starship.rs/install.sh | sh
    echo -e "${greenbg}Done installing dependancies!${reset}"
}

function opensuse() {       # - Untested - 
    # If $distro == openSUSE, then run this function
    echo -e "${green}${bold}Detected openSUSE.${reset}"
    sleep 2
    sudo zypper install -n neovim kitty neofetch zsh curl wget git fzf exa lsd starship
    echo -e "${greenbg}Done installing dependancies!${reset}"
}

function void_linux() {     # - Untested -
    # If $distro == Void Linux, then run this function
    echo -e "${green}${bold}Detected Void Linux.${reset}"
    sleep 2
    sudo xbps-install -Sy neovim kitty neofetch zsh curl wget git fzf exa lsd starship
    echo -e "${greenbg}Done installing dependancies!${reset}"
}


# --- Run above functions according to $distro ---

if [ "$distro" == "debian" ]; then
    echo "$distro -> debian"
    sleep 1
    debian
elif [ "$distro" == "arch" ]; then
    echo "$distro -> arch"
    sleep 1
    arch_linux
elif [ "$distro" == "fedora" ]; then
    echo "$distro -> rpm_based"
    sleep 1
    rpm_based
elif [ "$distro" == "opensuse" ]; then
    echo "$distro -> opensuse"
    sleep 1
    opensuse
elif [ "$distro" == "void" ]; then
    echo "$distro -> void_linux"
    sleep 1
    void_linux
else 
    echo -e "${redbg}Distro detected incorrectly or not supported. Skipping.${reset}"
    echo -e "${yellow}Detected distro:${reset} $distro"
    echo -e "${yellow}Distro Name (\$distroNAME):${reset} $distroNAME"
    echo -e "${yellow}Distro Like (\$distroLIKE):${reset} $distroLIKE"
fi
