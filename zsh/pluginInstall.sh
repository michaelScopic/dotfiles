#!/bin/bash 


. init.sh
# print zsh version
echo -e "$yellow ZSH version:$reset $(zsh --version)" ; sleep 1

# create the plugins directory
echo -e "
#################################
#$blue Creating a directory for $reset     #
#$blue plugins in:$red ~/.zsh-plugins...$reset #
#################################" 
mkdir ~/.zsh-plugins 2>/dev/null
sleep 1
echo -e "$greenbg Done. Going to install plugins...$reset"

# clone the plugins themselves
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh-plugins/zsh-autosuggestions 2>/dev/null
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting ~/.zsh-plugins/fsh 2>/dev/null
echo -e "$greenbg Finished installing plugins...$reset"
# make a backup of user's .zshrc and place my .zshrc in their ~/.zshrc
echo -e "
########################################
#$red Do you want to overwrite your $reset       #
#$red .zshrc with the one from here?  $reset     #
#$cyan I will make a backup of your current $reset#
#$cyan one called$purple '~/.zshrc.bak' $reset           #
########################################"
read -p "Overwrite? [Y/n]: " option
if [ "$option" != "n" ]
then
    mv -v $HOME/.zshrc $HOME/.zshrc.bak 2>/dev/null
    cp -v zshrc $HOME/.zshrc
    echo -e "$green Done! Reloading your shell...$reset"
    sleep 1 ; exec zsh
else
    echo -e "$redbg Ok, not overwriting. Exiting...$reset"
fi

exit 0
