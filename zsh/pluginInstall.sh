#!/bin/bash

# --- [Install oh-my-zsh] ---

echo "$(tput setaf 3)
##################################################
# Hello! This is a small script I made so that   #
# you can get up and running with oh-my-zsh!     #
# Do you already have oh-my-zsh installed? [y/N] #
# (note: this requires the installation of zsh)	 #
################################################## $(tput sgr 0) "
read -p "Do you have oh-my-zsh already installed? [y/N]: " OMZ_INSTALLED

if [ "$OMZ_INSTALLED" == "y" ] || [ "$OMZ_INSTALLED" == "Y" ]
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
read -p "Do you have the mentioned plugins already installed? [y/N]: " PLUGINS_INSTALLED

if [ "$PLUGINS_INSTALLED" == "y" ] || [ "$PLUGINS_INSTALLED" == "Y" ]
then
	echo "$(tput setaf 2) --- Perfect, I won't install them for you. Have fun and enjoy! --- $(tput sgr 0)"
else
	echo "$(tput setaf 3) --- Alright, I'll install them for you now, give me just one sec... ---"
	sleep 0.7
	git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
	echo "$(tput setaf 3) --- Done! Have fun! --- $(tput sgr 0)"
	echo "$(tput setaf 1) In order for the plugins to work, please put this into your ~/.zshrc: $(tput sgr 0)" 
	echo "plugins=(git zsh-autosuggestions zsh-syntax-highlighting)" 
fi

sleep 0.5


# --- [Appending my zsh aliases and autostart commands to ~/.zshrc] ---

echo "$(tput setaf 2) 
#############################################################
# Do you want to use my zsh aliases and autostart commands? #
# (recommended, but you don't have to) [Y/n]                #
############################################################# $(tput sgr 0)
"
read -p "Do you want to append my personal aliases and autostart commands to your .zshrc? [Y/n]: " ZSHRC_FILE

if [ "$ZSHRC_FILE" == "y" ] || [ "$ZSHRC_FILE" == " " ] || [ "$ZSHRC_FILE" == "Y" ]
then
	echo "--- Ok, appending my aliases and autostart to the end of your existing .zshrc..."
	cat .aaa.txt >> ~/.zshrc
	echo "$(tput setaf 2)--- Done! I highly recommend you look at your ~/.zshrc file and edit it to how you want it to be. ---$(tput sgr 0)"
	echo "--- DM me on Discord if you need any help:$(tput setaf 3) Michael_Scopic.sh#0102 $(tput sgr 0)---"
else
	echo "--- Ok, I will not append my aliases and autostart. ---"
	echo "--- If you want to look at my personal aliases, you can run: 'cat .aaa.txt' and/or you can look at my entire .zshrc file with: 'cat .zshrc' ---"
	echo "--- DM me on Discord if you need any help:$(tput setaf 3) Michael_Scopic.sh#0102 $(tput sgr 0)---"
fi

exit
