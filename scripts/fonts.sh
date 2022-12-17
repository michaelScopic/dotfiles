#!/bin/bash

#* Script to download needed fonts and install them

#* Fonts that will be downloaded:
#*  CaskaydiaCove NF, JetBrainsMono NF, FiraCode NF, Emoji Noto

#* These fonts are used in Kitty as part of 'kitty.conf'

# shellcheck disable=SC2154

echo -e "${purple}--- Beginning to install fonts... ---${reset}"

# --- Make sure we are on the dotfiles dir ---
cd "$dotfilesLoc"

# --- Make the fonts directory if it doesn't exist---
if [ ! -d "$HOME/.fonts" ]; then
    echo -e "${yellow}--- '${reset}~/.fonts/${yellow}' doesn't exist, so I will fix that. ---${reset} \n"
    mkdir -v "$HOME/.fonts"
fi

sleep 1

# --- Copy fonts ---
function install_fonts() {
    if [ ! "$(cp -rv fonts/* "$HOME/.fonts")" ]; then

        ## If copy failed, then tell user
        echo "Exit code: $?"
        echo -e "${red}${bold}--- Uh oh, copying fonts from '${reset}font/${red}${bold}' was not successful! ---${reset}"
        echo -e "${yellow}Command that failed: '${reset}cp -rv fonts/* $HOME/.fonts${yellow}'.${reset}"

        return 1

    else

        ## If copy was successful, then tell user then refresh font cache
        echo -e "${green}--- Successful! Refreshing font cache... ---${reset}"
        fc-cache -rv
        echo -e "${green}--- Done. ---${reset} \n"
        
    fi

    return
}
