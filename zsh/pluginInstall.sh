#!/bin/bash

# TODO: finish dependancies.sh

# * NOTES:
# *     Arco and EndeavourOS encounter a libssl error when cloning the plugins (something to do with 'sudo pacman -Sy <packages>' and then running 'sudo pacman -S <whatever>')

# Source init.sh
. init.sh

sleep 3

# Print zsh version
echo -e "${yellow}ZSH version:${reset} $(zsh --version)"
sleep 1

# --- Install dependancies ---
# !!! HUGE WIP !!!
echo -e "
###########################################
#${cyan}${bold} I am going to try to install the needed ${reset}# 
#${cyan}${bold} dependancies before continuing. ${reset}        #
#                                         #
#${purple}${bold} Supported distros: ${reset}                     #
#${blue}   Debian/Ubuntu ${reset}                        #
#${blue}   Arch based distros ${reset}                   #
#${blue}   RPM based distros, eg: ${reset}               #
#${blue}       Fedora ${reset}                           #
#${blue}       CentOS ${reset}                           #
#${blue}   openSUSE TW ${reset}                          #
#${blue}   Void Linux ${reset}                           #
########################################### \n
${redbg} !!! THIS DOES NOT FULLY WORK AS OF NOW !!!${reset} "

sleep 2

echo -e "
#########################################################
#${cyan}${bold} Dependancy list: ${reset}                                     #
#   ${blue}kitty${reset}                                               #
#   ${blue}neofetch${reset}                                            #
#   ${blue}zsh${reset}                                                 #
#   ${blue}starship ${red}*${reset}                                          #
#   ${blue}htop${reset}                                                #
#   ${blue}fzf${reset}                                                 #
#   ${blue}exa${reset}                                                 #
#   ${blue}lsd ${red}*${reset}                                               #
#   ${blue}curl${reset}                                                #
#   ${blue}wget${reset}                                                #
#                                                       #
# ${yellow}NOTE:${reset}                                                 #
# ${red}*${reset} = ${yellow}Not available in Debian/Ubuntu's repos, will use ${reset} #
#     ${yellow}a package/script to install it. ${reset}                  #                   
#########################################################
"

echo -e "${yellow}Do you want to install the dependancies? 
${red}Answer 'n' if you have the dependancies already installed (from my repo's wiki),
or if you have an unsupported distro. ${reset} \n"

read -p "Install dependancies? [Y\n]: " installDependancies

if [ "$installDependancies" == "y" ] || [ "$installDependancies" == "" ]; then
    echo -e "${green}${bold}Ok, installing dependancies.${reset}"
    bash -c ./dependancies.sh
else
    echo -e "${yellow}${bold}Ok, SKIPPING INSTALLATION of dependancies...\nYou are on your own for installing the dependancies...${reset}"
    sleep 1

fi

# --- Create the plugins directory ---
echo -e "
#################################
# ${blue}Creating a directory for ${reset}     #
# ${blue}plugins in:${red} ~/.zsh-plugins...${reset} #
#################################"

mkdir ~/.zsh-plugins 2>/dev/null
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
read -p "Overwrite? [Y/n]: " zsh_overwrite

if [ "$zsh_overwrite" != "n" ]; then
    # make a copy of user's zshrc and rename it as '.zshrc.bak'

    mv -v $HOME/.zshrc $HOME/.zshrc.bak 2>/dev/null
    # copy the zshrc from this directory to home as '.zshrc'

    cp -v zshrc $HOME/.zshrc

    echo -e "${greenbg}Done!${reset}"

else
    # skip overwriting zshrc and keep user's current one

    echo -e "${redbg}Ok, ${bold}not${reset}${redbg} overwriting.${reset}"

fi

sleep 1

# --- Starship prompt ---
echo -e "${cyan}${bold}Do you want to install the starship prompt? 
${red}(say 'n' if you already have Starship installed)${reset}"

read -p "Install starship? [Y/n]: " install_starship

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

exit 0
