#!/bin/bash

# Written by: michaelScopic (https://github.com/michaelScopic)

#* Script to install ZSH plugins and then optionally backup and overwrite user's zshrc with the one here.

# shellcheck disable=SC2154

# --- Print zsh version ---
echo -e "${yellow}ZSH version:${reset} $(zsh --version)"
sleep 1

# --- Install dependencies ---
echo -e "
####################
#${purple}${bold} Dependency list:${reset} #
#                  #
#${blue}   kitty         ${reset} #
#${blue}   neofetch      ${reset} #
#${blue}   zsh           ${reset} #
#${blue}   starship      ${reset} #
#${blue}   htop          ${reset} #
#${blue}   fzf           ${reset} #
#${blue}   exa           ${reset} #
#${blue}   lsd           ${reset} #
#${blue}   curl          ${reset} #
#${blue}   wget          ${reset} #
####################"

sleep 2

echo -e "
###################################
#${cyan}${bold} I can try to install the needed ${reset}# 
#${cyan}${bold} dependencies before continuing. ${reset}#
#                                 #
#${purple}${bold} Supported distros: ${reset}             #
#${blue}   Debian/Ubuntu distros ${reset} *      #
#${blue}   Arch distros ${reset} *               #
#${blue}   Fedora ${reset} *                     #
#${blue}   openSUSE TW ${reset} *                #
#${blue}   Void Linux ${reset} *                 #
#${blue}   Android ${reset}                      #
################################### 

* = ${yellow}Only works on x86_64 machines. (Except for Android) ${reset} \n"

echo -e "${yellow}Do you want to install the dependencies? 
${red}Answer 'n' if you have the dependencies already installed (from my repo's wiki),
${bold}or if you have an unsupported distro. ${reset} \n"

read -rp "Install dependencies? [Y\n]: " installDependencies

if [ "${installDependencies,,}" == "y" ] || [ "${installDependencies}" = "" ]; then

    echo -e "${green}${bold}Ok, installing dependencies.${reset}"
    bash -c scripts/./dependencies.sh

else

    echo -e "${yellow}${bold}SKIPPING INSTALLATION of dependencies...\nYou are on your own for that...\n${reset}"
    echo -e "${cyan}Message me on Discord (${purple}Michael_Scopic.zsh#0102${cyan}) if you want me to add support for another distro.${reset}"
    sleep 1

fi

# --- Create the zsh config dir ---
echo -e "
#################################
#${yellow} Creating a directory for ZSH  ${reset}#
#${yellow} configs in: ${purple}~/.zsh-stuff/${yellow} ... ${reset}#
#################################"

if [ -d "$HOME/.zsh-stuff/" ]; then
    # If '~/.zsh-stuff' doesnt exist, create it
    mkdir -vp ~/.zsh-stuff/{plugins,dist-aliases}
fi

echo -e "${green}Done. Going to install plugins...${reset}"

# --- Install plugins ---
echo -e "
###################################
#${yellow} Plugins that will be installed:${reset} #
#${blue}  fast-syntax-highlighting ${reset}      #
#${blue}  zsh-autosuggestions ${reset}           #
#${blue}  fzf-tab ${reset}                       #
#${blue}  zsh-interactive-cd ${reset}            #
###################################"

sleep 2

# -- Clone plugin repos --

# autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh-stuff/plugins/zsh-autosuggestions 2>/dev/null && \
echo -e "${blue}Finished installing autosuggestions...${reset}"

# syntax highlighting
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting ~/.zsh-stuff/plugins/fsh 2>/dev/null && \
echo -e "${blue}Finished installing syntax highlighting...${reset}"

# Fuzzy tab
git clone https://github.com/Aloxaf/fzf-tab ~/.zsh-stuff/plugins/fzf-tab 2>/dev/null && \
echo -e "${blue}Finished installing fuzzy tab completion...${reset}"

# fish -like cd
git clone https://github.com/changyuheng/zsh-interactive-cd.git ~/.zsh-stuff/plugins/zsh-interactive-cd/ 2>/dev/null && \
echo -e "${blue}Finished installing fish cd...${reset}"

echo -e "${greenbg}Finished installing plugins...${reset}"

sleep 1

# --- Overwrite .zshrc ---
# make a backup of user's .zshrc and place my .zshrc in their ~/.zshrc
echo -e "
########################################
# ${red}${bold}Do you want to overwrite your ${reset}       #
# ${red}${bold}.zshrc with my zshrc?  ${reset}              #
# ${cyan}I will make a backup of your current ${reset}#
# ${cyan}one called${purple} '~/.zshrc.bak' ${reset}           #
########################################"

read -rp "Overwrite? [Y/n]: " zshOverwrite

if [ "${zshOverwrite,,}" == "y" ] || [ "${zshOverwrite}" = "" ]; then
    # Make a copy of user's zshrc and rename it as '.zshrc.bak'
    cp -v --backup=t "$HOME"/.zshrc "$HOME"/.zshrc.bak 3>/dev/null
    
    # Copy the zshrc from this directory to home as '.zshrc'
    cp -v zsh/zshrc "$HOME"/.zshrc

    # Backup .zsh-stuff/ if exists
    cp -v --backup=t "$HOME"/.zsh-stuff/* "$HOME"/.zsh-stuff.bak/ 2>/dev/null
    
    # Copy zsh-stuff/ to ~
    cp -vr zsh/zsh-stuff/* "$HOME"/.zsh-stuff/ 

    echo -e "${greenbg}Done!${reset}"

else
    # Skip overwriting zshrc and keep user's current one

    echo -e "${redbg}Ok, ${bold}not${reset}${redbg} overwriting.${reset}"

fi

sleep 1

# --- Starship prompt ---
echo -e "${cyan}${bold}Do you want to install the starship prompt? 
${red}(say 'n' if you already have Starship installed)${reset}"

read -rp "Install starship? [Y/n]: " install_starship

if [ "${install_starship,,}" == "y" ] || [ "${install_starship}" == "" ]; then
    # If user pressed enter or 'y', we will install starship

    echo -e "${green}Ok. Installing Starship prompt...${reset}"

    # Offical install script from https://starship.rs , this is safe.
    curl -sS https://starship.rs/install.sh | sh

else

    echo -e "${red}Ok. ${bold}Not${reset}${red} installing Starship. \n ${reset}"

fi
