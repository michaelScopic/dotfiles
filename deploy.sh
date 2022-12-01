#!/bin/bash

#* This is a script to automate deploying these dotfiles onto the user's machine

#! This is a huge WIP, not usable right now.

# TODO: Fix the dotfilesLoc var


# --- Store the dotfiles dir location as a var ---

export dotfilesLoc="$(realpath "$0" | rev | cut -d '/' -f 2- | rev )"
echo -e "Dotfiles location: $dotfilesLoc \n"

# --- Make the initalization a function ---
function init_script() {
    source "$dotfilesLoc"/scripts/init.sh
    return
}

# --- Make the plugin and dependency installation as a function ---
function plugins() {
    bash -c scripts/./pluginInstall.sh
    ## 'pluginInstall.sh' will then call 'dependencies.sh', so no need to include it here

    return
}

# --- Backup function ---
function backup() {

    # -- Backup htop config --
    echo -e "${blue}${bold}Attempting to backup htop... \n ${reset}" 
    sleep 1

    if [ -d "$HOME"/.config/htop ]; then 
    ## If htop config dir exists, back it up (no not that kind of "back it up" smh)

        cp -v "$HOME"/.config/htop/htoprc "$HOME"/.config/htop/htoprc.bak

        echo -e "${green}Success! A backup of your current htoprc is in:${reset} '~/.config/htop/htoprc.bak' \n"
        sleep 1

    else 
        ## If htop config dir isn't found, skip the backup

        echo -e "${yellow}${bold}Hmmm, I couldn't find ${reset}'~/.config/htop/'${yellow}${bold}. Skipping backup. \n ${reset}"
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
        rsync -av --exclude='backups' "$HOME"/.config/kitty/ "$HOME"/.config/kitty/backups && \
        
        echo -e "${green}Success! Your current Kitty configs are in:${reset} '~/.config/kitty/backups' \n"
        sleep 1

    else
        ## If kitty config dir isn't found, skip the backup

        echo -e "${yellow}${bold}Hmmm, I couldn't find ${reset}'~/.config/kitty/'${yellow}${bold}. Skipping backup. \n ${reset}"
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
        rsync -av --exclude='backups' "$HOME"/.config/neofetch/ "$HOME"/.config/neofetch/backups && \
        echo -e "${green}Success! Your current neofetch configs are in:${reset} '~/.config/neofetch/backups' \n"

        sleep 1
    else
        ## If neofetch config dir doesn't exist, skip it
        echo -e "${yellow}${bold}Hmmm, I couldn't find ${reset}'~/.config/neofetch/'${yellow}${bold}. Skipping backup. \n ${reset}"
        sleep 1
    fi

    # -- Backup starship config --
    echo -e "${blue}${bold}Attempting to backup starship prompt... \n ${reset}"
    sleep 1

    if [ -f "$HOME"/.config/starship.toml ]; then
        ## If 'starship.toml' exists, back it up.
        cp -v "$HOME"/.config/starship.toml "$HOME"/.config/starship.toml.bak && \
        echo -e "${green}Success! A backup of your current starship config is in:${reset} '~/.config/starship.toml.bak' \n"
        sleep 1
    else 
        ## If 'starship.toml' doesn't exist, skip it
        echo -e "${yellow}${bold}Hmmm, I couldn't find ${reset}'~/.config/starship.toml'${yellow}${bold}. Skipping backup. \n ${reset}"
        sleep 1
    fi

    echo -e "${greenbg}Finished backing up everything that I could find!${reset} \n"
    sleep 1

    return
}

# -- Overwrite user's configs with the dotfiles' configs ---
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
    ########################### \n"

    read -rp "Do you want to continue with overwritting your current configs? [Y\n]: " config_overwrite

    if [ "${config_overwrite,,}" = "y" ] || [ "$config_overwrite" = "" ]; then

        cd "$dotfilesLoc"/config/ || exit 1

        # Copy htoprc
        cp -v htop/htoprc "$HOME"/.config/htop/htoprc || \
        echo -e "${yellow}Couldn't copy '${reset}htoprc${yellow}', does '${reset}~/.config/htop/${yellow}' directory exist?${reset}\n"
        sleep 1

        # Copy kitty config
        cp -v kitty/{*.ini,kitty.conf} "$HOME"/.config/kitty/ || \
        echo -e "${yellow}Couldn't copy kitty configs, does '${reset}~/.config/kitty/${yellow}' directory exist?${reset}\n"
        sleep 1

        # Copy neofetch
        cp -v neofetch/config.conf "$HOME"/.config/neofetch/ || \
        echo -e "${yellow}Couldn't copy neofetch configs, does '${reset}~/.config/neofetch/${yellow}' directory exist?${reset}\n"
        sleep 1

        # Copy starship 
        echo -e "${red}About to copy over a Starship prompt."
        echo -e "${cyan}You have a few choices here - do you want to use the ${red}default ${cyan}prompt, ${purple}rounded ${cyan}prompt, or the ${green}plain text ${cyan}prompt?${reset}"
        echo -e "${yellow}(Note: for the ${blue}default ${yellow}and ${purple}rounded ${yellow}prompts, you will need a patched nerd font.)${reset}"
        read -rp "What starship prompt do you want to use? [default\rounded\plain]: " starshipPrompt

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
        esac 

        echo -e "${green}Done overwriting configs!${reset} \n"

    else 

        echo -e "${red}Skipping overwritting configs... \n ${reset}"
        return 0

    fi
    
    return
}

# --- Usage/help function
function usage() {
    ## Prints usage for script

    echo -e "Bad argument: '$*' "
    echo -e "Usage: './deploy.sh AGRUMENTS' \n"
    
    echo "Possible agruments:"
    echo "all       ->     Run all functions:"
    echo "                 (Install dependencies/ZSH plugins -> backup current configs -> overwrite configs)"
    echo "plugins   ->     Just install ZSH plugins and dependencies"
    echo "backup    ->     Just backup user's current configs (htop, kitty, neofetch, starship prompt)"
    echo "overwrite ->     Just overwrite user's current configs with the ones in this repo"
    echo "help      ->     Print this menu"

    return 1

}

# --- Read arguments passed ---
case $1 in
    all)    ## Call all functions (plugins -> backups -> overwrite)
        init_script
        bash -c "$dotfilesLoc"/scripts/info.sh
        plugins
        backup
        overwrite
        exit
    ;;

    plugins) ## Just call the plugin funct
        init_script
        bash -c "$dotfilesLoc"/scripts/info.sh
        plugins
        exit
    ;; 

    backup) ## Just call the backup funct
        init_script
        source "$dotfilesLoc"/scripts/info.sh
        backup
        exit
    ;;

    overwrite) ## Call the overwrite funct
        init_script
        source "$dotfilesLoc"/scripts/info.sh
        overwrite
        exit
    ;;

    help) 
        usage
        exit
    ;;

    *)  ## Any other agrument pass just runs the help funct       
        usage "$@"
        exit 
    ;;
esac

