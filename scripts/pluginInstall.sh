#!/bin/bash


# Source init.sh
# . init.sh

#sleep 3

# Print zsh version
echo -e "${yellow}ZSH version:${reset} $(zsh --version)"
sleep 1

# --- Install dependancies ---
echo -e "
####################
#${purple}${bold} Dependancy list:${reset} #
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

echo -e "
###################################
#${cyan}${bold} I can try to install the needed ${reset}# 
#${cyan}${bold} dependancies before continuing. ${reset}#
#                                 #
#${purple}${bold} Supported distros: ${reset}             #
#${blue}   Debian/Ubuntu distros ${reset}        #
#${blue}   Arch distros ${reset}                 #
#${blue}   Fedora ${reset}                       #
#${blue}   openSUSE TW ${reset}                  #
#${blue}   Void Linux ${reset}                   #
#${blue}   Android ${red}* ${reset}                    #
################################### 

${red}*${reset} = ${yellow}This script is made for x86_64 machines, but does works on Android. You're welcome :) ${reset} \n"

sleep 2

echo -e "${yellow}Do you want to install the dependancies? 
${red}Answer 'n' if you have the dependancies already installed (from my repo's wiki),
or if you have an unsupported distro. ${reset} \n"

read -rp "Install dependancies? [Y\n]: " installDependancies

if [ "$installDependancies" == "y" ] || [ "$installDependancies" == "" ]; then

    echo -e "${green}${bold}Ok, installing dependencies.${reset}"
    bash -c ./dependencies.sh

else

    echo -e "${yellow}${bold}Ok, SKIPPING INSTALLATION of dependencies...\nYou are on your own for that...\n${reset}"
    echo -e "${cyan}Message me on Discord (${purple}Michael_Scopic.zsh#0102${cyan}) if you want me to add support for another distro.${reset}"
    sleep 1

fi

# --- Create the plugins directory ---
echo -e "
#################################
# ${blue}Creating a directory for ${reset}     #
# ${blue}plugins in:${red} ~/.zsh-plugins...${reset} #
#################################"

mkdir ~/.zsh-plugins 
echo -e "${greenbg}Done. Going to install plugins...${reset}"

# --- Install plugins ---
echo -e "
###################################
#${yellow} Plugins that will be installed:${reset} #
#${blue}  fast-syntax-highlighting ${reset}      #
#${blue}  zsh-autosuggestions ${reset}           #
#${blue}  fzf-tab ${reset}                       #
#${blue}  zsh-interactive-cd ${reset}            #
###################################" && sleep 2

# -- Clone plugin repos --

# autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh-plugins/zsh-autosuggestions 2>/dev/null

# syntax highlighting
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting ~/.zsh-plugins/fsh 2>/dev/null

# Fuzzy tab
git clone https://github.com/Aloxaf/fzf-tab ~/.zsh-plugins/fzf-tab 2>/dev/null

# fish -like cd
git clone https://github.com/changyuheng/zsh-interactive-cd.git ~/.zsh-plugins/zsh-interactive-cd/ 2>/dev/null

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
read -rp "Overwrite? [Y/n]: " zsh_overwrite

if [ "$zsh_overwrite" != "n" ]; then
    # make a copy of user's zshrc and rename it as '.zshrc.bak'

    mv -v "$HOME"/.zshrc "$HOME"/.zshrc.bak 2>/dev/null
    # copy the zshrc from this directory to home as '.zshrc'

    cp -v ../zsh/zshrc "$HOME"/.zshrc

    echo -e "${greenbg}Done!${reset}"

else
    # skip overwriting zshrc and keep user's current one

    echo -e "${redbg}Ok, ${bold}not${reset}${redbg} overwriting.${reset}"

fi

sleep 1

# --- Starship prompt ---
echo -e "${cyan}${bold}Do you want to install the starship prompt? 
${red}(say 'n' if you already have Starship installed)${reset}"

read -rp "Install starship? [Y/n]: " install_starship

if [ "$install_starship" == "" ] || [ "$install_starship" == "y" ]; then
    # if user pressed enter or 'y', we will install starship

    echo -e "${green}Ok. Installing Starship prompt...${reset}"

    # offical install script from https://starship.rs , this is safe.
    curl -sS https://starship.rs/install.sh | sh

else

    echo -e "${red}Ok. ${bold}not${reset}${red} installing Starship."

fi

echo -e "${greenbg}Done with everything! Reloading your shell for you! Enjoy!${reset}"
exec zsh

exit
