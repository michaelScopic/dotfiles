#!/usr/bin/env sh 

# print zsh version
echo "\e[46mZSH version:\e[0m $(zsh --version)" ; sleep 1

# create the plugins directory
echo "
#################################
# \e[33mCreating a directory for \e[0m     #
# \e[33mplugins in: \e[32m~/.zsh-plugins...\e[0m #
#################################" 
mkdir ~/.zsh-plugins 2>/dev/null
sleep 1
echo "\e[33mDone. Going to install plugins...\e[0m"

# clone the plugins themselves
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh-plugins/zsh-autosuggestions 2>/dev/null
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting ~/.zsh-plugins/fsh 2>/dev/null
echo "\e[32mFinished installing plugins...\e[0m"
# make a backup of user's .zshrc and place my .zshrc in their ~/.zshrc
echo "
########################################
# \e[31mDo you want to overwrite your \e[0m       #
# \e[31m.zshrc with the one from here?  \e[0m     #
# \e[31mI will make a backup of your current \e[0m#
# \e[31mone called \e[33m'~/.zshrc.bak' \e[0m           #
########################################"
read -p "Overwrite? [Y/n]: " option
if [ "$option" != "n" ]
then
    mv -v $HOME/.zshrc $HOME/.zshrc.bak 2>/dev/null
    cp -v zshrc $HOME/.zshrc
    echo "\e[32m Done! Reloading your shell...\e[0m"
    sleep 1 ; exec zsh
else
    echo "\e[31mOk, not overwriting. Exiting...\e[0m"
fi

exit 0
