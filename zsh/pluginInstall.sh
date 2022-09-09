#!/usr/bin/env sh 

# print zsh version
echo "$(tput setaf 3)ZSH version: $(tput sgr 0)$(zsh --version)" ; sleep 1

# create the plugins directory
echo "
/////////////////////////////////
/ $(tput setaf 2)Creating a directory for $(tput sgr 0)     /
/ $(tput setaf 2)plugins in: $(tput setaf 1)~/zsh-plugins...$(tput sgr 0) /
///////////////////////////////// " && mkdir ~/zsh-plugins && echo "Done. Installing plugins..."

# clone the plugins themselves
git clone https://github.com/zsh-users/zsh-autosuggestions ~/zsh-plugins/zsh-autosuggestions
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting ~/zsh-plugins/fsh

# make a backup of user's .zshrc and place my .zshrc in their ~/.zshrc
echo "
////////////////////////////////////////
/ $(tput setaf 3)Do you want to overwrite your $(tput sgr 0)       /
/ $(tput setaf 3).zshrc with the one from here? $(tput sgr 0)      /
/ $(tput setaf 3)I will make a backup of your current $(tput sgr 0)/
/ $(tput setaf 3)one called '~/.zshrc.bak' $(tput sgr 0)           /
////////////////////////////////////////"
read -p "Overwrite? [Y/n]: " option
if [ "$option" != "n" ]
then
    mv -v $HOME/.zshrc $HOME/.zshrc.bak
    cp -v zshrc $HOME
    echo "$(tput setaf 2)Done! Reloading your shell...$(tput sgr 0)"
    sleep 1 ; exec zsh
else
    echo "$(tput setaf 1)Ok, not overwriting. Exiting...$(tput sgr 0)"
fi

exit 0