#!/bin/bash

# * Script to install dependancies according to user's distro/package manager
# * USED IN: pluginInstall.sh

# TODO: Test on different distros/derivatives
# ? Add support for Gentoo???

# ! Derivates NOT WORKING (as of now): Linux Mint,
# ! Distros NOT WORKING (as of now):
# ! Distros planned to be tested: Linux Mint/LMDE,  EndeavourOS,  Nobara, Aquamarine, CentOS,

#* Debian working distros: Ubuntu, Debian (fixed),
#* Arch working distros: Arch, Manjaro (only with $distroLIKE), Arco **, EndeavourOS **, ArchLabs,
#* RPM working distros: Fedora,
#* openSUSE working?: YES
#* Void Linux working?: YES

#* Distro compatability notes:
#*    ** = Arco and EndeavourOS encounters a libssl error when cloning plugins in pluginInstall.sh???

# --- Set colors ---
# Not sourcing init.sh just for colors bc it's dumb. I will manually set colors here
reset='\e[0m'
bold='\e[1m'
red='\e[31m'
redbg='\e[41m'
green='\e[32m'
greenbg='\e[42m'
yellow='\e[33m'
yellowbg='\e[43m'
blue='\e[34m'
bluebg='\e[44m'
purple='\e[35m'
purplebg='\e[45m'
cyan='\e[36m'
cyanbg='\e[46m'

# --- Set current dir as var ---
thisDir=$(pwd)

# --- Find user's distro and store it as a variable ---
distroNAME="$(cat /etc/os-release | grep ^NAME | awk -F'"' '{print $2 }')"
distroLIKE="$(cat /etc/os-release | grep ^ID_LIKE | awk -F= '{ print $2 }')"
#distroID="$(cat /etc/os-release | grep ^ID | awk -F= '{ print $2 }')"
# Print what we found
echo -e "${blue}${bold}NAME:${reset} $distroNAME ${red}| ${cyan}${bold}LIKE:${reset} $distroLIKE"

# --- Workarounds for different distros ---
if [ "$distroNAME" == "Debian GNU/Linux" ]; then
    # Simplify pure Debian's $distroNAME

    distroNAME="debian"

elif [ "$distroLIKE" == '"ubuntu debian"' ]; then
    # Correct Linux Mint's $distroLIKE

    distroLIKE="debian"

elif [ "$distroLIKE" == '"arch"' ]; then
    # Correct Arch based distro's $distroLIKE

    distroLIKE="arch"

elif [ "$distroNAME" == "Fedora Linux" ]; then
    # Simplify Fedora's $distroNAME

    distroNAME="fedora"

elif [ "$distroLIKE" == '"opensuse suse"' ]; then
    # Simplify openSUSE's $distroNAME

    distroLIKE="opensuse"

fi

# --- Choose what var to use ---
if [ "$distroLIKE" == "" ]; then
    # if $distroLIKE has nothing, then perfer $distroNAME

    distro=$distroNAME

    echo -e "Using ${cyan}\$distroNAME ${reset}as {$cyan}\$distro:${reset} ($distro)"

else
    # If $distroLIKE isn't empty, then prefer $distroID

    distro=$distroLIKE

    echo -e "Using ${purple}${bold}\$distroLIKE ${reset}as ${blue}${bold}\$distro:${reset} ($distro)"

fi

# --- Distro functions ---
function debian() {
    # If we pick up a Debian or Ubuntu based distro, then run this

    echo -e "${green}${bold}Detected Debian/Ubuntu.${reset}"
    sleep 2

    # Install deps
    sudo apt-get install -y git kitty htop neofetch zsh curl wget htop fzf exa

    # Installing lsd
    mkdir ${thisDir}/.tmp/
    cd ${thisDir}/.tmp/

    # Get the lsd .deb file
    wget https://github.com/Peltoche/lsd/releases/download/0.23.1/lsd_0.23.1_amd64.deb && \

    # Install the .deb file
    sudo dpkg -i lsd_0.23.1_amd64.deb && \

    # Remove .tmp after installing lsd
    cd ${thisDir}/
    rm -rfv ${thisDir}/.tmp/

    # Installing starship
    curl -sS https://starship.rs/install.sh | sh

    echo -e "${greenbg}Done installing dependancies!${reset}"
}

function arch_linux() {
    # If we pick up an Arch based distro, then run this

    echo -e "${green}${bold}Detected Arch Linux.${reset}"
    sleep 2

    # Install deps
    sudo pacman -Sy --noconfirm starship kitty htop neofetch zsh curl wget git htop fzf exa lsd

    echo -e "${greenbg}Done installing dependancies!${reset}"
}

function rpm_based() {
    # If we pick up a rpm based distro, then run this function

    echo -e "${green}${bold}Detected an RPM based distro.${reset}"
    sleep 2

    # Install deps
    sudo dnf install -y neovim kitty htop neofetch zsh curl wget git fzf exa lsd || \
    # If dnf doesn't work, then fall back to yum
    sudo yum install -y neovim kitty htop neofetch zsh curl wget git fzf exa lsd

    # Install starship
    curl -sS https://starship.rs/install.sh | sh

    echo -e "${greenbg}Done installing dependancies!${reset}"
}

function opensuse() {
    # If we pick up openSUSE, then run this function

    echo -e "${green}${bold}Detected openSUSE.${reset}"
    sleep 2

    # Install deps
    sudo zypper -n install neovim kitty htop neofetch zsh curl wget git fzf exa lsd starship

    echo -e "${greenbg}Done installing dependancies!${reset}"
}

function void_linux() {
    # If we pick up Void Linux, then run this function

    echo -e "${green}${bold}Detected Void Linux.${reset}"
    sleep 2

    # Install deps
    sudo xbps-install -Sy neovim kitty htop neofetch zsh curl wget git fzf exa lsd starship

    echo -e "${greenbg}Done installing dependancies!${reset}"
}

# --- Run above functions according to $distro ---
if [ "$distro" == "debian" ]; then

    echo -e "$distro -> ${red}debian()${reset}"
    sleep 1

    debian

elif [ "$distro" == "arch" ]; then

    echo -e "$distro -> ${blue}arch${reset}"
    sleep 1
    arch_linux

elif [ "$distro" == "fedora" ]; then

    echo -e "$distro -> ${yellow}rpm_based()${reset}"
    sleep 1

    rpm_based

elif [ "$distro" == "opensuse" ]; then

    echo -e "$distro -> ${green}opensuse()${reset}"
    sleep 1

    opensuse

elif [ "$distro" == "Void" ]; then

    echo -e "$distro -> ${purple}void_linux()${reset}"
    sleep 1

    void_linux

else
    # If we can't correctly detect distro then run this section

    echo -e "${redbg}Distro detected incorrectly or not supported. Skipping.${reset}"
    echo -e "${yellow}Detected distro:${reset} $distro"
    echo -e "${yellow}Distro Name (\$distroNAME):${reset} $distroNAME"
    echo -e "${yellow}Distro Like (\$distroLIKE):${reset} $distroLIKE"

fi
