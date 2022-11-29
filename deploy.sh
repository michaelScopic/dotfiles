#!/bin/bash

#* This is a script to automate deploying these dotfiles onto the user's machine

#! This is a huge WIP, not usable right now.

# TODO: Make all major steps a function 
# TODO: Add options 
# TODO: Make help section
# ? try to add options (ex: for skipping installing zsh plugins or skip configs)??

# --- Read arguments passed ---
case $1 in
    all)    ## Run all functions (plugins -> backups -> overwrite)
        source scripts/./init.sh
        bash -c scripts/./pluginInstall.sh
        backup
        overwrite
        exit $?
        ;;

    plugin) ## Just run the plugin installer
        source scripts/./init.sh
        bash -c scripts/./pluginInstall.sh
        exit $?
        ;; 
       
    backup) ## Just backup configs
        source scripts/./init.sh
        backup
        exit $?
        ;;

    overwrite) ## Just overwrite configs
        source scripts/./init.sh
        overwrite
        exit $?
        ;;

    *)  ## Any other agrument pass just runs the usage/help function       
        usage
        exit 1
        ;;
esac

# --- Run initalizer ---
#source scripts/./init.sh
#---------------------------------------------#



# -- Run the zsh plugin installer --
#bash -c scripts/./pluginInstall.sh
## ^ This script will try to handle the dependencies with 'dependencies.sh', so no need to run that here.



# --- Backup user's config files first ---
function backup() {

    # -- Backup htop config --
    echo -e "${blue}${bold}Attempting to backup htop... \n ${reset}" 
    sleep 1

    if [ -d "$HOME"/.config/htop ]; then 
    ## If htop config dir exists, back it up (no not that kind of "back it up" smh)

        cp -v "$HOME"/.config/htop/htoprc "$HOME"/.config/htop/htoprc.bak   ## Backup file is in the same dir but ends in '.bak'

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

        mkdir -v "$HOME"/.config/kitty/backups  ## Backups are in the kitty config dir

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
        mkdir -v "$HOME"/.config/neofetch/backups   ## Backups are in the neofetch config dir
    
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
    read -rp "Do you want to continue with overwritting your current configs? [Y\n]: " configOverwrite

    if [ "$configOverwrite,," = "y" ] || [ "$configOverwrite" == "" ];then
        #cd ../config/ || \
        #    echo -e "${red}Couldn't cd into the config directory! Aborting! 
        #   Maybe you're not in the correct directory when you ran this script?${reset}"; exit 1
        cd config/ || \
        echo -e ""; exit 1
        # Copy htoprc
        cp -v htop/htoprc "$HOME"/.config/htop/
    
        # Copy kitty config
        cp -v kitty/{*.ini,kitty.conf} "$HOME"/.config/kitty/

        # Copy neofetch
        cp -v neofetch/config.conf "$HOME"/.config/neofetch/

        # Copy starship 
        echo -e "${cyan}You have a few choices here, do you want to use the ${blue}default prompt${cyan}, ${purple}rounded prompt${cyan}, or the ${green}plain text prompt?${reset}"
        read -rp "What starship prompt do you want to use? [default\rounded\plain]: " starshipPrompt

        case $starshipPrompt in
            default)
                echo -e "${blue}Using the default prompt... \n ${reset}"
                rm "$HOME"/.config/starship.toml 
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

    else 
        echo -e "${red}Skipping copying starship configs... \n ${reset}"
    fi
}

# --- Usage/help function
function usage() {
    ## Prints usage for script
    echo -e "Usage: './deploy.sh [all|plugins|backup|overwrite|help]' \n"
    
    echo "Agruments: "
    echo "all       ->     Run all functions: (plugins -> backup -> overwrite)"
    echo "plugins   ->     Just install ZSH plugins and dependencies"
    echo "backup    ->     Just backup user's current configs (htop, kitty, neofetch, starship prompt)"
    echo "overwrite ->     Just overwrite user's current configs with the ones in this repo"
    echo "help      ->     Print this menu"

}




