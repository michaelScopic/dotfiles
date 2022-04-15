#!/bin/bash

# --- [Install oh-my-zsh] ---

echo "$(tput setaf 3)
##################################################
# Hello! This is a small script I made so that   #
# you can get up and running with oh-my-zsh!     #
# Do you already have oh-my-zsh installed? [y/N] #
################################################## $(tput sgr 0) "
read -p "Do you have oh-my-zsh already installed?: " OMZ_INSTALLED

if [ "$OMZ_INSTALLED" == "y" ]
then
	echo "$(tput setaf 2) --- Nice, I won't install that for you then. --- $(tput sgr 0)"
else
	echo "$(tput setaf 3) --- Ok, I will install oh-my-zsh for you now... ---"
	echo "$(tput setaf 2) --- Once oh-my-zsh is installed, please re-run this script and answer "y" to the first question. --- $(tput sgr 0)"
	sleep 1
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" 
	exit
fi

# --- [Install oh-my-zsh plugins] ---

echo "$(tput setaf 3)
#######################################################
# Ok, now with the oh-my-zsh plugins. Do you have     #
# 'zsh-autosuggestions' and 'zsh-syntax-highlighting' #
# installed? [y/N] 				      #
####################################################### $(tput sgr 0) "
read -p "Do you have the mentioned plugins already installed?: " PLUGINS_INSTALLED

if [ "$PLUGINS_INSTALLED" == "y" ]
then
	echo "$(tput setaf 2) --- Perfect, I won't install them for you. Have fun and enjoy! --- $(tput sgr 0)"
else
	echo "$(tput setaf 3) --- Alright, I'll install them for you now, give me just one sec... ---"
	sleep 0.7
	bash git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
	bash git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
	echo "$(tput setaf 3) --- Done! Have fun! --- $(tput sgr 0)"
	echo "$(tput setaf 1) In order for the plugins to work, please put this into your .zshrc: $(tput sgr 0)" 
	echo "plugins=(git zsh-autosuggestions zsh-syntax-highlighting)" 
fi

sleep 0.5

clear

# --- [copying my .zshrc] ---

echo "$(tput setaf 2) 
########################################
# Do you want to use my .zshrc config? #
# (recommended) [Y/n] 		       #
######################################## $(tput sgr 0)
"
read -p "Do you want to use my .zshrc file? (recommended): " ZSHRC_FILE

if [ "$ZSHRC_FILE" == "y" ] || [ "$ZSHRC_FILE" == " " ]
then
	echo "--- Ok, copying my .zshrc file to your home directory..."
	cat .aaa.txt >> .zshrc
	echo "--- Done! I recommend you look over at the .zshrc file and make your own changes. ---"
else
	echo "--- Ok, I will not copy my .zshrc file. ---"
fi

exit
