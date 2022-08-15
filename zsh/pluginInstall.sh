#!/usr/bin/env zsh

# create the plugins directory
echo "
/////////////////////////////////
/ $(tput setaf 2)Creating a directory for $(tput sgr 0)     /
/ $(tput setaf 2)plugins in: $(tput setaf 1)~/zsh-plugins...$(tput sgr 0) /
///////////////////////////////// " && mkdir ~/zsh-plugins

# clone the plugins themselves
git clone https://github.com/zsh-users/zsh-autosuggestions ~/zsh-plugins/zsh-autosuggestions
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting ~/zsh-plugins/fsh

# make a backup of user's .zshrc and place my .zshrc in their ~/.zshrc
mv -v ~/.zshrc ~/.zshrc.bak
cp -v .zshrc ~

# finish up..
echo "
////////////////
/ $(tput setaf 2)Done! Enjoy! $(tput sgr 0)/
//////////////// " && exit 0
