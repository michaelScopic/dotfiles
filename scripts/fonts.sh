#!/bin/bash

#* Script to download needed fonts and install them

#* Fonts that will be downloaded:
#*  CaskaydiaCove NF, JetBrainsMono NF, FiraCode NF, Emoji Noto

#* These fonts are used in Kitty as part of 'kitty.conf'

# shellcheck disable=SC2154

echo -e "${purple}--- Beginning to install fonts... --- \n"

# --- Set fonts directory ---
if [ -d "$HOME"/.fonts ]; then
    ## If '~/.fonts' exists, then use that
    echo -e "${green}Found '${reset}~/.fonts/${green}'... Using that as the fonts directory.${reset} \n"
    fontsDest="$HOME/.fonts"
elif [ -d "/usr/share/fonts" ]; then
    ## If it doesn't exist, then use '/usr/share/fonts'
    echo -e "${yellow}Couldn't find '${reset}~/.fonts/${yellow}'... Falling back to '${reset}/usr/share/fonts/${yellow}'.${reset} \n"
    fontsDest="/usr/share/fonts"
else
    ## If both don't exist, then abort
    echo -e "${redbg}${bold}!!! -- FATAL -- !!!${reset}"
    echo -e "${red}${bold}Could not find either '${reset}~/.fonts/${red}${bold}' or '${reset}/usr/share/fonts/${red}${bold}'. Aborting!${reset} \n"
    
fi

# --- Download fonts ---
function download_fonts() {
    echo -e "${purple}--- Downloading fonts... ---${reset} \n"
    mkdir -v "$thisDir"/.font_tmp 
    cd "$thisDir"/.font_tmp || return 1

    ## Download CaskaydiaCove
    wget -q https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/CascadiaCode.zip &&
        echo -e "${green}Successfully downloaded '${reset}CaskaydiaCove${green}'.${reset} \n"

    ## Download JetBrains
    wget -q https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/JetBrainsMono.zip &&
        echo -e "${green}Successfully downloaded '${reset}JetBrainsMono${green}'.${reset} \n"

    ## Download FiraCode
    wget -q https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/FiraCode.zip &&
        echo -e "${green}Successfully downloaded '${reset}FiraCode${green}'.${reset} \n"

    echo -e "${cyan}--- Done downloading fonts! ---${reset} \n"

    return
}

function install_fonts() {
    echo -e "${purple}--- Extracting/installing fonts... ---${reset} \n"

    ## Extract CaskaydiaCove
    mkdir -v "$fontDest"/CaskaydiaCove/

    ## Extract JetBrainsMono
    mkdir -v "$fontsDest"/JetBrainsMono/

    ## Extract FiraCode
    mkdir -v "$fontsDest"/FiraCode/

    return
}



echo -e "
####################
# ${redbg}!!! WARNING !!!${reset}  #
# ${red}This script is${reset}   #
# ${red}not usable right${reset} #
# ${red}now... Aborting!${reset} #
#################### \n"

exit 1