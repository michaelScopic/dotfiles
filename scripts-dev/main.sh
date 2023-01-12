#!/usr/bin/env bash

#* Script to do everything

# ! Requirements: bash, rsync,

# TODO: put everything from '.../scripts/' into here
# TODO: Make everything a function

function init() {
    echo -e "--- Initalizing... ---"

    if [ ! -f /etc/os-release ]; then
        # If we can't source '/etc/os-release', then set a var to "false" let install_deps() know about it
        echo "Cannot find '/etc/os-release'..."
        echo "I will not be able to detect your distro."
        can_detect_distro="false"
    else
        # If file is found, source it and set the var to "true"
        echo "Found '/etc/os-release'!"
        . /etc/os-release 
        can_detect_distro="true"
    fi

    # - Set colors -
    echo -e "- Setting colors... - "
    # Normal text
    reset='\e[0m'
    # Bold text
    bold='\e[1m'
    # Red
    red='\e[31m'
    redbg='\e[41m'
    # Green
    green='\e[32m'
    greenbg='\e[42m'
    # Yellow
    yellow='\e[33m'
    yellowbg='\e[43m'
    # Blue
    blue='\e[34m'
    bluebg='\e[44m'
    # Purple
    purple='\e[35m'
    purplebg='\e[45m'
    # Cyan
    cyan='\e[36m'
    cyanbg='\e[46m'
    echo -e "${cyan}- Done setting colors. -${reset}"

    # - Store user's current dir as a var -
    thisDir=$(pwd)
    echo -e "${purple}${bold}Current directory:${reset} $thisDir"

    # - Finish up -
    echo -e "${green}${bold}--- Done initalizing. ---${reset} \n"

    if [ $can_detect_distro == "false" ]; then
        echo -e "${red}Error: Unable to find '${reset}/etc/os-release${red}'.${reset}" 
        echo -e "${red}I won't be able to automatically install dependencies.${reset} \n"
    fi
}

# --- Detect Distro ---
function detect_distro() {
    if [ $can_detect_distro == "false" ]; then
        # If init wasn't able to find os-release, then abort this function
        echo -e "${yellow}DEBUG: Current function: detect_distro(), line 65${reset}"
        echo -e "${red}ERROR: Initalizer was could not to find '/etc/os-release'.${reset}"
        echo -e "${red}ERROR: Unable to detect distro...${reset} \n"
        return 1
    fi 

    echo "Name: ${NAME}"
    echo "ID: ${ID}"
    echo "ID like: ${ID_LIKE}"
    echo "Pretty name: ${PRETTY_NAME}"
    echo ""

    if [ "${ID}" == "ubuntu" ] || [ "${ID}" == "debian" ] || [ "${ID_LIKE}" == '"ubuntu debian"' ] || [ "${ID_LIKE}" == "debian" ]; then
        echo "Found Ubuntu/Debian."
        distro="debian"

    elif [ "${ID}" == "arch" ] || [ "${ID_LIKE}" == '"arch"' ] || [ "${ID}" == "artix" ]; then
        echo "Found Arch Linux."
        distro="arch"

    elif [ "${ID}" == "fedora" ]; then
        echo "Found Fedora Linux."
        distro="rhel"

    elif [ "${NAME}" == "openSUSE Tumbleweed" ]; then
        echo "Found openSUSE Tumbleweed."
        distro="opensuse"
    
    elif [ "${NAME}" == "void" ]; then
        echo "Found Void Linux."
        distro="void"

    else 
        echo -e "${red}ERROR: Couldn't detect your distro${reset}"
        echo -e "${yellow}INFO: Supported distros:
        ${blue}Ubuntu/Debian, Arch/Manjaro/Artix/EndeavourOS/Arco, Fedora, OpenSUSE TW, Void Linux ${reset}\n"

    fi
}

function info() {
    # --- Print out basic info about system ---
    echo -e "${bold}---------- Basic info ----------${reset}"
    # Print the distro (needs '/etc/os-release' for this part)
    echo -e "${green}${bold}Distro:${reset} ${PRETTY_NAME}"
    # Print kernel version
    echo -e "${yellow}${bold}Kernel:${reset} $(uname -srm)"
    # Print shell
    echo -e "${blue}${bold}Shell:${reset} $SHELL"
    # Print hostname
    echo -e "${purple}${bold}Hostname:${reset} $(cat /etc/hostname 2>/dev/null || uname -n)"
    # Print CPU name
    echo -e "${red}${bold}CPU:${reset} $(lscpu | grep "Model name:" | sed -r 's/Model name:\s{1,}//g')"
    # Print current user
    echo -e "${cyan}${bold}User:${reset} $(whoami)"
    echo -e "${bold}-------------------------------- \n${reset}"

    sleep 2

}

# --- Copy ZSH configs ---
function zsh_install() {
    true; # Placeholder for now

}

# --- Install dependancies ---
function install_deps() {
    if [ $can_detect_distro == "false" ]; then
        echo -e "${red}${bold}ERROR:${reset} ${red}The initalizer process was unable to find '${reset}/etc/os-release${red}'.${reset}"
        echo -e "${red}${bold}ERROR:${reset} ${red}Because of this, I won't be able to install dependencies for you. You are on your own for that. :( ${bold}Aborting!${reset} \n"
        return 1
    fi

    



}

# --- Install fonts ---
function install_fonts() {
    if [ ! -d "$HOME/.fonts" ]; then
        ## Check if '~/.fonts' exist. If not, then create it
        echo -e "${yellow}--- '${reset}~/.fonts/${yellow}' does not yet exist, fixing that. ---${reset} \n"
        mkdir -v "$HOME/.fonts"
    fi

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


}

# --- Backup function ---
function zsh() {
    bash -c "$dotfilesLoc"/scripts/zshInstall.sh
    ## 'zshInstall.sh' will then call 'dependencies.sh', so no need to include it here

    return
}

# --- Backup function ---
function backup() {
    echo -e "${cyan}Backing up configs... (htop, kitty, neofetch, starship)${reset}"
    echo -e "${yellow}* Note: 'rsync' is needed to backup kitty and neofetch. ${reset}"

    # -- Backup htop config --
    echo -e "${blue}${bold}Attempting to backup htop... \n ${reset}"
    sleep 1

    if [ -d "$HOME"/.config/htop ]; then
        ## If htop config dir exists, backup that

        cp -v "$HOME/.config/htop/htoprc" "$HOME/.config/htop/htoprc.${date +%}.bak"

        echo -e "${green}Success! A backup of your current htoprc is in:${reset} '~/.config/htop/htoprc.bak' \n"
        sleep 1

    else
        ## If htop config dir isn't found, skip the backup

        echo -e "${red}${bold}Hmmm, I couldn't find ${reset}'~/.config/htop/'${red}${bold}. Skipping backup. \n ${reset}"
        sleep 1
    fi

    # -- Backup kitty config --
    echo -e "${blue}${bold}Attempting to back up kitty...\n ${reset}"
    sleep 1

    if [ -d "$HOME/.config/kitty/" ]; then
        ## Backup if kitty config dir exists; some people might not have kitty already installed

        mkdir -v "$HOME"/.config/kitty/backups

        ## Using rsync bc cp doesn't have a '--exclude' option to prevent the backups dir to copy into itself
        #cp -v "$HOME"/.config/kitty "$HOME"/.config/kitty/backups && \
        rsync -av --exclude='backups' "$HOME"/.config/kitty/ "$HOME"/.config/kitty/backups &&
            echo -e "${green}Success! Your current Kitty configs are in:${reset} '~/.config/kitty/backups' \n"

        sleep 1

    else
        ## If kitty config dir isn't found, skip the backup

        echo -e "${red}${bold}Hmmm, I couldn't find ${reset}'~/.config/kitty/'${red}${bold}. Skipping backup.${reset}"

        echo -e "${yellow}Note: I need 'rsync' to be able to do this backup!${reset} \n"
        sleep 1

    fi

    # -- Backup neofetch config --
    echo -e "${blue}${bold}Attempting to back up neofetch... \n ${reset}"
    sleep 1

    if [ -d "$HOME"/.config/neofetch ]; then
        ## If neofetch config dir exists, make a backup
        mkdir -v "$HOME"/.config/neofetch/backups

        ## Using rsync bc cp doesn't have a '--exclude' option to prevent the backups dir to copy into itself
        #cp -rv "$HOME/.config/neofetch" ~/.config/neofetch/backups/ && \
        rsync -av --exclude='backups' "$HOME"/.config/neofetch/ "$HOME"/.config/neofetch/backups &&
            echo -e "${green}Success! Your current neofetch configs are in:${reset} '~/.config/neofetch/backups' \n"

        sleep 1
    else
        ## If neofetch config dir doesn't exist, skip it
        echo -e "${yellow}Exit code:${reset} $?"
        echo -e "${red}${bold}Hmmm, I couldn't find ${reset}'~/.config/neofetch/'${red}${bold}. Skipping backup.${reset}"
        echo -e "${yellow}Note: I need 'rsync' to be able to do this backup!${reset} \n"
        sleep 1
    fi

    # -- Backup starship config --
    echo -e "${blue}${bold}Attempting to backup starship prompt... \n ${reset}"
    sleep 1

    if [ -f "$HOME"/.config/starship.toml ]; then
        ## If 'starship.toml' exists, back it up.
        cp -v "$HOME"/.config/starship.toml "$HOME"/.config/starship.toml.bak &&
            echo -e "${green}Success! A backup of your current starship config is in:${reset} '~/.config/starship.toml.bak' \n"
        sleep 1
    else
        ## If 'starship.toml' doesn't exist, skip it
        echo -e "${red}${bold}Hmmm, I couldn't find ${reset}'~/.config/starship.toml'${red}${bold}. Skipping backup. \n ${reset}"
        sleep 1
    fi

    echo -e "${greenbg}Finished backing up everything that I could find!${reset} \n"
    sleep 1

    return
}

# --- Overwrite function ---
function overwrite() {
    echo -e "
    ###########################
    #${red} I am about to overwrite${reset} #
    #${red} your configs.${reset}           #
    #                         #
    #${purple} Configs affected:${reset}       #
    #${blue}  htop ${reset}                  #
    #${blue}  neofetch ${reset}              #
    #${blue}  kitty ${reset}                 #
    #${blue}  starship ${reset}              #
    ###########################\n"

    read -rp "Do you want to continue with overwritting your current configs? [Y\n]: " config_overwrite

    if [ "${config_overwrite,,}" == "y" ] || [ "${config_overwrite}" = "" ]; then

        cd "$dotfilesLoc"/config/ || return 1

        ## Copy htoprc
        read -rp "Do you want to overwrite htop config? [Y/n]: " htopOverwrite

        if [ "${htopOverwrite,,}" == "y" ] || [ "${htopOverwrite}" = "" ]; then
            mkdir -p "$HOME"/.config/htop/ 2>/dev/null
            cp -v htop/htoprc "$HOME"/.config/htop/htoprc &&
                echo -e "${green}Copied htoprc config!${reset}"
            sleep 1
        else
            echo -e "${red}Not overwritting htop...${reset}"
        fi

        ## Copy kitty config
        read -rp "Do you want to overwrite kitty config? [Y/n]: " kittyOverwrite

        if [ "${kittyOverwrite,,}" == "y" ] || [ "${kittyOverwrite}" = "" ]; then
            mkdir -p "$HOME"/.config/kitty/ 2>/dev/null
            cp -rv kitty/* "$HOME"/.config/kitty/ &&
                echo -e "${green}Copied kitty configs!${reset}"
            sleep 1
        else
            echo -e "${red}Not overwritting kitty...${reset}"
        fi

        ## Copy neofetch
        read -rp "Do you want to overwrite neofetch config? [Y/n]: " neofetchOverwrite

        if [ "${neofetchOverwrite,,}" == "y" ] || [ "${neofetchOverwrite}" = "" ]; then
            mkdir -p "$HOME"/.config/neofetch/ 2>/dev/null
            cp -v neofetch/config.conf "$HOME"/.config/neofetch/ &&
                echo -e "${green}Copied neofetch configs!${reset}"
            sleep 1
        else
            echo -e "${red}Not overwritting neofetch...${reset}"
        fi

        ## Copy starship
        echo -e "${red}About to copy over a Starship prompt."
        echo -e "${yellow}Note: for the ${blue}default ${yellow}, ${purple}rounded ${yellow}, and ${purple} nord ${yellow}prompts, you will need a patched nerd font.${reset}"
        read -rp "What starship prompt do you want to use? [default/rounded/nord/plain/skip] (skip): " starshipPrompt

        case ${starshipPrompt,,} in
        default)
            echo -e "${blue}Using the default prompt... \n ${reset}"
            rm "$HOME"/.config/starship.toml 2>/dev/null
            ;;

        rounded)
            echo -e "${blue}Using 'rounded.toml' as the prompt... \n ${reset}"
            cp starship/rounded.toml "$HOME"/.config/starship.toml
            ;;

        plain)
            echo -e "${blue}Using the plain text prompt... \n ${reset}"
            cp starship/plain-text-symbols.toml "$HOME"/.config/starship.toml
            ;;

        nord)
            echo -e "${blue}Using the nord prompt... Fancy. \n ${reset}"
            cp starship/nord-starship.toml "$HOME"/.config/starship.toml
            ;;

        skip | *)
            echo -e "${red}Not going to copy a starship prompt...\n ${reset}"
            ;;

        esac

        echo -e "${green}Done overwriting configs!${reset} \n"

    else

        echo -e "${red}Skipping overwritting configs... \n ${reset}"
        return 0

    fi

    return
}

# --- Help menu ---
function usage() {
    ## Prints usage for script

    echo -e "${red}${bold}Bad argument: ${reset}'$*' "
    echo -e "${yellow}Usage: ${reset}'./deploy.sh ${blue}AGRUMENTS${reset}' \n"

    echo -e "${bold}Possible agruments:${reset}"
    echo -e "${blue}${bold}all${reset}       ->     ${cyan}Run all functions:"
    echo -e "                 (Install dependencies/ZSH plugins -> backup current configs -> overwrite configs)${reset}"

    echo -e "${blue}${bold}zsh${reset}       ->     ${cyan}Just install ZSH plugins and dependencies${reset}"

    echo -e "${blue}${bold}fonts${reset}     ->     ${cyan}Just install fonts"

    echo -e "${blue}${bold}backup${reset}    ->     ${cyan}Just backup user's current configs (htop, kitty, neofetch, starship prompt)${reset}"

    echo -e "${blue}${bold}overwrite${reset} ->     ${cyan}Just overwrite user's current configs with the ones in this repo${reset}"

    echo -e "${blue}${bold}info${reset}      ->     ${cyan}Print some basic info of this machine${reset}"

    echo -e "${blue}${bold}help${reset}      ->     ${cyan}Print this menu${reset}"

    return 255

}

init
info
detect_distro