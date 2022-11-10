#!/bin/bash 


. init.sh
# print zsh version
echo -e "${yellow}ZSH version:${reset} $(zsh --version)" ; sleep 1

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

if [ "$zsh_overwrite" != "n" ]
then
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
echo -e "${cyan}${bold}Do you want to install the starship prompt?${reset}"

read -p "Install starship? [Y/n]: " install_starship
if [ "$install_starship" == "" ]  || [ "$install_starship" == "y" ]
then
    # if user said anything but 'n', we will install starship
    echo -e "${green}Ok. Installing Starship prompt...${reset}"
    # offical install script from https://starship.rs , this is safe.
    curl -sS https://starship.rs/install.sh | sh
else 
    echo -e "${red}Ok. ${bold}not${reset}${red} installing Starship."
fi

echo -e "${greenbg}Done with everything! Reloading your shell for you! Enjoy!${reset}"
exec zsh

exit 0