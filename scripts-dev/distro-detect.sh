#!/usr/bin/env bash

function dependencies() {
    echo "$OSTYPE"
    if [[ $OSTYPE == "linux-gnu" ]]; then

        if command -v apt-get >/dev/null; then
            echo "Found Debian/Ubuntu."
            sudo apt-get install -y git kitty htop neofetch zsh curl wget htop fzf exa unzip
            # - 'rsync' isn't installing when put in the above line, installing it seperately
            sudo apt-get install -y rsync
            # Installing lsd
            mkdir "${buildDir}"
            cd "${buildDir}" || exit 1
            # Get the lsd .deb file
            wget https://github.com/Peltoche/lsd/releases/download/0.23.1/lsd_0.23.1_amd64.deb &>/dev/null &&
            # Install the .deb file
            sudo dpkg -i lsd_0.23.1_amd64.deb && \
            cd ${repoDir}
            # Installing starship
            curl -sS https://starship.rs/install.sh | sh
            echo -e "${greenbg}Done installing dependancies!${reset} \n"

        elif command -v pacman >/dev/null; then
            echo "Found Arch Linux."
            sudo pacman -S --noconfirm starship kitty htop neofetch zsh curl wget git htop fzf exa lsd rsync unzip
            echo -e "${greenbg}Done installing dependencies!${reset} \n"

        elif command -v zypper >/dev/null; then
            echo "Found openSUSE."
            sudo zypper -n install neovim kitty htop neofetch zsh curl wget git fzf exa lsd starship rsync unzip
            echo -e "${greenbg}Done installing dependancies!${reset}"

        elif command -v dnf >/dev/null; then
            echo "Found RHEL."
            sudo dnf install -y neovim kitty htop neofetch zsh curl wget git fzf exa lsd rsync unzip
            # Install starship
            curl -sS https://starship.rs/install.sh | sh
            echo -e "${greenbg}Done installing dependancies!${reset}"


        elif command -v xbps-install >/dev/null; then
            echo "Found Void Linux."
            sudo xbps-install -Suy neovim kitty htop neofetch zsh curl wget git fzf exa lsd starship rsync unzip
            echo -e "${greenbg}Done installing dependancies!${reset}"

        else
            echo "Couldn't detect your package manager. Unable to install packages."
        fi
    
    else 
        echo "Your OS is not Linux! There is no support for BSD or Darwin hosts. Unable to install packages."
    fi

}

dist_detect