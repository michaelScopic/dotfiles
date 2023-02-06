#!/usr/bin/env bash

#* Script to do everything

# shellcheck disable=SC2145

# ! Requirements: bash, rsync, coreutils

# TODO: put everything from '.../scripts/' into here
# TODO: Make everything a function

# --- Initalization function ---
function init() {
    echo -e "--- Initalizing... ---"

    # - Set colors -
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

    # - Set 'info', 'error', 'note', 'success' message functions -
    msg_info() {
        echo -e "${yellow}${bold}[INFO]${reset} $@ ${reset}"
    }

    msg_error() {
        echo -e "${red}${bold}[ERROR]${reset} $@ ${reset}"
    }

    msg_success() {
        echo -e "${green}${bold}[SUCCESS]${reset} $@ ${reset}"
    }

    msg_note() {
        echo -e "${blue}${bold}[NOTE]${reset} $@ ${reset}"
    }

    msg_success "Done setting colors and message functions."

    # - Source /etc/os-release -
    if [[ -f /etc/os-release ]]; then
        . /etc/os-release
        msg_success "Sourced '${cyan}/etc/os-release${reset}'."
    else
        msg_error "Could not find '${cyan}/etc/os-release${reset}'."
        msg_error "Unable to source '${cyan}/etc/os-release${reset}'."
    fi

    # - Store user's current dir as a var -
    thisDir=$(pwd)
    buildDir="$HOME/.build_tmp"
    dotfilesLoc=$(realpath "$0" | rev | cut -d '/' -f 2- | rev)
    backup_format=$(date +%F_%I-%M-%S-%p)

    msg_info "Current directory: ${cyan}$thisDir${reset}"
    msg_info "Dotfiles directory: ${cyan}$dotfilesLoc${reset}"
    msg_info "Backup format: ${cyan}$backup_format${reset}"

    msg_note "A temporary directory will be made in '${cyan}$buildDir${reset}' if needed."

    # - Finish up -
    msg_success "Done initallizing! \n"

}

# --- Function for printing info ---
function info() {
    get_distro() {
        local distro_name
        if command -v lsb_release >/dev/null; then
            distro_name=$(lsb_release -ds)
        else
            if [[ ! -f /etc/os-release ]]; then
                distro_name="${PRETTY_NAME}"
            else 
                distro_name="Unknown"
            fi
        fi
        echo "$distro_name"
    }

    get_cpu() {
        # Get model
        local cpu_model
        cpu_model=$(grep 'model name' /proc/cpuinfo | uniq | cut -d ':' -f 2-)

        # Get cores/threads
        local cpu_threads
        local cpu_cores
        cpu_threads=$(nproc)
        cpu_cores=$(grep -m 1 'cpu cores' /proc/cpuinfo | cut -d ':' -f 2-)

        # Print result
        echo "$cpu_model ($cpu_cores/$cpu_threads)"
    }

    # --- Print out basic info about system ---
    echo -e "${bold}---------- Basic info ----------${reset}"
    echo -e "${green}${bold}Distro:${reset} $(get_distro)"
    # Print kernel version
    echo -e "${yellow}${bold}Kernel:${reset} $(uname -srm)"
    # Print shell
    echo -e "${blue}${bold}Shell:${reset} $SHELL"
    # Print hostname
    echo -e "${purple}${bold}Hostname:${reset} $(cat /etc/hostname 2>/dev/null || uname -n)"
    # Print CPU name
    #    echo -e "${red}${bold}CPU:${reset} $(lscpu | grep "Model name:" | sed -r 's/Model name:\s{1,}//g')"
    echo -e "${red}${bold}CPU:${reset} $(get_cpu)"
    # Print current user
    echo -e "${cyan}${bold}User:${reset} $(whoami)"
    echo -e "${bold}-------------------------------- \n${reset}"

    return
}

# --- Install dependencies ---
function dependencies() {
    msg_info "Installing dependencies for ZSH."
    msg_info "What will be installed:"
    msg_info "git kitty htop neofetch zsh curl wget fzf exa unzip vim rsync lsd \n"
    sleep 2

    if [[ $(uname -s) == "Linux" ]] && [[ $(uname -m) == "x86_64" ]]; then
        if command -v apt-get >/dev/null; then
            msg_info "Found Debian/Ubuntu."
            sudo apt-get install -y git kitty htop neofetch zsh curl wget fzf exa unzip vim
            ## 'rsync' isn't installing when put in the above line, installing it seperately
            sudo apt-get install -y rsync

            # Installing lsd/exa
            msg_info "Making a temporary build directory..."
            mkdir "$buildDir"
            cd "$buildDir"
            # Get the lsd .deb file
            wget https://github.com/Peltoche/lsd/releases/download/0.23.1/lsd_0.23.1_amd64.deb &>/dev/null
            wget https://github.com/ogham/exa/releases/download/v0.10.1/exa-linux-x86_64-v0.10.1.zip &>/dev/null &&
                # Install the .deb files
                sudo dpkg -i ./*.deb &>/dev/null &&
                cd "$repoDir"
            msg_info "Removing temporary build directory..."
            rm -vrf "${buildDir}"

            # Installing starship
            curl -sS https://starship.rs/install.sh | sh
            msg_success "Done installing dependencies!"

        elif command -v pacman >/dev/null; then
            msg_info "Found Arch Linux."
            sudo pacman -S --noconfirm starship kitty htop neofetch zsh curl wget git htop fzf exa lsd rsync unzip vim
            msg_success "Done installing dependencies!"

        elif command -v zypper >/dev/null; then
            msg_info "Found openSUSE."
            sudo zypper -n install kitty htop neofetch zsh curl wget git fzf exa lsd starship rsync unzip vim
            msg_success "Done installing dependencies!"

        elif command -v dnf >/dev/null; then
            msg_info "Found RHEL/Fedora Linux."
            sudo dnf install -y kitty htop neofetch zsh curl wget git fzf exa lsd rsync unzip vim
            # Install starship
            curl -sS https://starship.rs/install.sh | sh
            msg_success "Done installing dependencies!"

        elif command -v xbps-install >/dev/null; then
            msg_info "Found Void Linux."
            sudo xbps-install -Suy kitty htop neofetch zsh curl wget git fzf exa lsd starship rsync unzip vim
            msg_success "Done installing dependencies!"

        elif command -v nix-env >/dev/null; then
            msg_info "Found NixOS/nixpkgs."
            sudo nix-env -i kitty htop neofetch-unstable zsh curl wget git fzf exa lsd starship rsync unzip vim
            msg_success "Done installing dependencies!"

            # - Show user how to change their default shell in NixOS -
            msg_note "You might need to edit '${cyan}/etc/nixos/configuration.nix${reset}' and change your default shell to zsh."
            msg_note " --- Example (/etc/nixos/configuration.nix) --- "
            msg_note "users.users.alice = {"
            msg_note "  isNormalUser = true;"
            msg_note "  extraGroups = [ \"wheel\" ];"
            msg_note "${green}  shell = pkgs.zsh; ${reset}"
            msg_note "  packages = with pkgs; [ "
            msg_note "  ];"
            msg_note "};"
            msg_note " ---------------------------------------------- "
            sleep 3

        else
            msg_error "Unable to detect your package manager!"
            msg_error "You will need to install the dependencies yourself. \n"
            msg_info "Supported package managers are:"
            msg_info "'apt-get', 'pacman', 'zypper', 'dnf', 'xbps-install', and 'nix-env' \n"
            msg_note "Message me on Discord (${purple}Michael_Scopic.zsh#0102${reset}) if you want to request adding support for another package manager."

            sleep 2
            return 1

        fi

    else
        # If host is not Linux based and CPU is not x86_64, then print an error.
        # BSD or Darwin hosts or hosts that are not x86 will encounter this.
        msg_error "Detected OS is ${bold}not${reset} x86_64 Linux."
        msg_error "There is no support for BSD or Darwin (MacOS) hosts."
        msg_error "There is no support for Linux hosts that aren't x86_64 (amd64)."
        msg_error "You will need to install the dependencies yourself."
        sleep 3

        return 1
    fi

}

# --- Install fonts ---
function install_fonts() {
    msg_note "Installing fonts..."
    cd "$dotfilesLoc"

    if [ ! -d "$HOME/.fonts" ]; then
        # Check if '~/.fonts' exist. If it doesn't exist, create it
        msg_info "'${cyan}~/.fonts${reset}' does not exist yet, fixing that."
        mkdir -v "$HOME/.fonts"
    fi

    if [ ! "$(cp -rv fonts/* "$HOME/.fonts")" ]; then
        # If copy failed, then tell user
        msg_error "Exit code: $?"
        ## ^ Shellcheck will warn about reffering to "$?", this is fine.
        msg_error "Could not copy fonts to '${cyan}~/.fonts/${reset}'."
        msg_error "Command that failed: '${blue}cp -rv fonts/* $HOME/.fonts${reset}'"
        return 1
    else
        # If copy was successful, then tell user then refresh font cache
        msg_success "Copied fonts! Reloading font cache..."
        msg_info "Running: '${purple}fc-cache -rv${reset}'"
        fc-cache -rv &&
            msg_success "Finished reloading font cache!"
    fi
}

# --- ZSH function ---
function install_zsh() {
    msg_note "Installing ZSH plugins and configs..."
    cd "$dotfilesLoc"

    if [ -d "$HOME/.config/zsh" ]; then
        # If '~/.zsh-stuff' doesnt exist, create it
        msg_info "'${cyan}~/.config/zsh/${reset} does not exist. Fixing that."
        mkdir -vp ~/.config/zsh/{plugins,dist-aliases} &&
            msg_success "Done creating '${cyan}~/.config/zsh/${reset}'!"
    fi

    msg_info "Continuing to install ZSH plugins..."

    # --- Install plugins ---
    echo -e "
###################################
#${yellow} Plugins that will be installed:${reset} #
#${blue}  fast-syntax-highlighting ${reset}      #
#${blue}  zsh-autosuggestions ${reset}           #
#${blue}  fzf-tab ${reset}                       #
#${blue}  zsh-interactive-cd ${reset}            #
###################################"

    sleep 2

    # -- Clone plugin repos --
    # autosuggestions
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.config/zsh/plugins/zsh-autosuggestions 2>/dev/null &&
        echo -e "${blue}Finished installing autosuggestions...${reset}"

    # syntax highlighting
    git clone https://github.com/zdharma-continuum/fast-syntax-highlighting ~/.config/zsh/plugins/fsh 2>/dev/null &&
        echo -e "${blue}Finished installing syntax highlighting...${reset}"

    # Fuzzy tab
    git clone https://github.com/Aloxaf/fzf-tab ~/.config/zsh/plugins/fzf-tab 2>/dev/null &&
        echo -e "${blue}Finished installing fuzzy tab completion...${reset}"

    # fish -like cd
    git clone https://github.com/changyuheng/zsh-interactive-cd.git ~/.config/zsh/plugins/zsh-interactive-cd/ 2>/dev/null &&
        echo -e "${blue}Finished installing fish cd...${reset}"

    msg_success "Finished installing plugins!"

    sleep 1

    # --- Overwrite .zshrc ---
    # make a backup of user's .zshrc and place my .zshrc in their ~/.zshrc
    echo -e "
########################################
# ${red}${bold}Do you want to overwrite your ${reset}       #
# ${red}${bold}.zshrc with my zshrc?  ${reset}              #
# ${cyan}I will make a backup of your current ${reset}#
# ${cyan}one called${purple} '~/.zshrc.bak' ${reset}           #
########################################"

    read -rp "Overwrite? [Y/n]: " zshOverwrite

    if [ "${zshOverwrite,,}" == "y" ] || [ "${zshOverwrite}" = "" ]; then
        # If user answered yes (or pressed enter), run this
        msg_info "Answered 'yes'. Continuing..."

        # Make a copy of user's zshrc and rename it as '.zshrc.bak'
        cp -v "$HOME/.zshrc" "$HOME/.zshrc-$backup_format.bak" 2>/dev/null

        # Copy the zshrc from this directory to home as '.zshrc'
        cp -v zsh/zshrc "$HOME/.zshrc"

        # Backup .config/zsh/ if exists
        mkdir -v "$HOME/.config/zsh-$backup_format.d.bak"
        cp -v "$HOME/.config/zsh/*" "$HOME/.config/zsh-$backup_format.d.bak/" 2>/dev/null

        # Copy zsh-stuff/ to ~/.config/zsh/
        cp -vr zsh/zsh-stuff/* "$HOME/.config/zsh/"
        msg_success "Done copying ZSH configs!"

    else
        # If user answered no, then skip overwriting zshrc
        msg_info "Answered 'no'. Skipping overwritting zsh."

    fi

    sleep 1

    # --- Starship prompt ---
    msg_info "Do you want to install Starship using the offical install script?"
    msg_info "Press 'n' if you don't want to install it, or if you already have it installed."

    read -rp "Install starship? [Y/n]: " install_starship

    if [ "${install_starship,,}" == "y" ] || [ "${install_starship}" == "" ]; then
        # If user pressed enter or 'y', we will install starship
        msg_info "User answered 'yes', continuing to install Starship..."
        msg_info "Running command:${purple} curl -sS https://starship.rs/install.sh | sh"
        # Offical install script from https://starship.rs , this is safe.
        curl -sS https://starship.rs/install.sh | sh
    else
        msg_info "User answered 'no', skipping installation of Starship."
    fi

}

# --- Backup function ---
function backup() {
    msg_info "Attempting to back up current configs..."
    msg_info "Trying to back up htop, neofetch, kitty, and starship configs, if possible."
    msg_note "rsync is needed to backup up kitty and neofetch. \n"

    # -- Backup htop config --
    msg_info "Attempting to backup htop..."
    sleep 1

    if [ -d "$HOME"/.config/htop ]; then
        ## If htop config dir exists, backup that
        mkdir -v "$HOME/.config/htop/backups/" 2>/dev/null
        cp -v "$HOME/.config/htop/htoprc" "$HOME/.config/htop/backups/htoprc-$backup_format.bak"

        msg_success "A backup of htop is in: ${cyan}~/.config/htop/backups/htoprc-$backup_format.bak${reset} \n"
        sleep 1

    else
        ## If htop config dir isn't found, skip the backup
        msg_error "Unable to find '${cyan}~/.config/htop/${reset}', cannot backup htop. \n"
        sleep 1

    fi

    # -- Backup kitty config --
    msg_info "Attempting to backup kitty..."
    sleep 1

    if [ -d "$HOME/.config/kitty/" ]; then
        ## Backup if kitty config dir exists; some people might not have kitty already installed

        mkdir -v "$HOME/.config/kitty/backups/$backup_format" 2>/dev/null

        ## Using rsync bc cp doesn't have a '--exclude' option to prevent the backups dir to copy into itself
        #cp -v "$HOME"/.config/kitty "$HOME"/.config/kitty/backups && \
        rsync -av --exclude='backups' "$HOME"/.config/kitty/ "$HOME/.config/kitty/backups/$backup_format" &&
            msg_success "A backup of kitty is in:${cyan} ~/.config/kitty/backups/$backup_format \n"

        sleep 1

    else
        ## If kitty config dir isn't found, skip the backup
        msg_error "Unable to find '${cyan}~/.config/kitty/${reset}', cannot backup kitty."
        msg_note "rsync is need to backup kitty! \n"
        sleep 1

    fi

    # -- Backup neofetch config --
    msg_info "Attempting to backup neofetch..."
    sleep 1

    if [ -d "$HOME"/.config/neofetch ]; then
        ## If neofetch config dir exists, make a backup
        mkdir -v "$HOME/.config/neofetch/backups/$backup_format"

        ## Using rsync bc cp doesn't have a '--exclude' option to prevent the backups dir to copy into itself
        #cp -rv "$HOME/.config/neofetch" ~/.config/neofetch/backups/ && \
        rsync -av --exclude='backups' "$HOME/.config/neofetch/" "$HOME/.config/neofetch/backups/$backup_format/" &&
            msg_success "A backup of neofetch configs are in:${cyan} ~/.config/neofetch/backups/$backup_format \n"

        sleep 1
    else
        ## If neofetch config dir doesn't exist, skip it
        msg_error "Unable to find '${cyan}~/.config/neofetch/${reset}', cannot backup neofetch."
        msg_note "rsync is needed to backup neofetch."
        sleep 1
    fi

    # -- Backup starship config --
    msg_info "Attempting to backup Starship..."
    sleep 1

    if [ -f "$HOME"/.config/starship.toml ]; then
        ## If 'starship.toml' exists, back it up.
        cp -v "$HOME"/.config/starship.toml "$HOME/.config/starship.toml.$backup_format.bak" &&
            msg_success "A backup of your current starship config is in:${cyan} ~/.config/starship.toml.$backup_format.bak \n"
        sleep 1
    else
        ## If 'starship.toml' doesn't exist, skip it
        msg_error "Unable to find '${cyan}~/.config/starship.toml${reset}', cannot backup Starship."
        msg_note "If you aren't using Starship, or if you're using the default Starship prompt, this is safe to ignore."
        sleep 1
    fi

    msg_success "Finished backing up everything!"
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

        cd "$dotfilesLoc/config/" ||
            # If for some reason we can't enter back into the dotfiles config folder, then abort.
            msg_error "FATAL! Could not enter '${cyan}$dotfilesLoc/config/${reset}'. ABORTING!" &&
            exit 1

        ## Copy htoprc
        read -rp "Do you want to overwrite htop config? [Y/n]: " htopOverwrite

        if [ "${htopOverwrite,,}" == "y" ] || [ "${htopOverwrite}" = "" ]; then
            mkdir -p "$HOME"/.config/htop/ 2>/dev/null
            cp -v htop/htoprc "$HOME"/.config/htop/htoprc &&
                msg_success "Copied over htop config."
            sleep 1
        else
            msg_info "Skipping overwriting htop."
        fi

        ## Copy kitty config
        read -rp "Do you want to overwrite kitty config? [Y/n]: " kittyOverwrite

        if [ "${kittyOverwrite,,}" == "y" ] || [ "${kittyOverwrite}" = "" ]; then
            mkdir -p "$HOME"/.config/kitty/ 2>/dev/null
            cp -rv kitty/* "$HOME"/.config/kitty/ &&
                msg_success "Copied over kitty configs."
            sleep 1
        else
            msg_info "Skipping overwriting kitty configs."
        fi

        ## Copy neofetch
        read -rp "Do you want to overwrite neofetch config? [Y/n]: " neofetchOverwrite

        if [ "${neofetchOverwrite,,}" == "y" ] || [ "${neofetchOverwrite}" = "" ]; then
            mkdir -p "$HOME"/.config/neofetch/ 2>/dev/null
            cp -v neofetch/config.conf "$HOME"/.config/neofetch/ &&
                msg_success "Copied over neofetch configs."
            sleep 1
        else
            msg_info "Skipping overwriting neofetch configs."
        fi

        ## Copy starship
        msg_info "Copying a Starship prompt."
        msg_note "All of these prompt presets will need a patched nerd font (except for the 'plain' preset)."
        msg_note "Running '${purple}./shell-install.sh fonts${reset}' or '${purple}./shell-install.sh all${reset}' will install the nerd fonts for you."
        msg_note "Alternatively, you can install your own fonts manually by visiting: https://nerdfonts.com/ \n"

        read -rp "What starship prompt do you want to use? [default/rounded/rxyhn/plain/skip] (default: skip): " starshipPrompt

        case ${starshipPrompt,,} in
        default)
            msg_info "Using the default Starship prompt."
            msg_note "This will remove '${cyan}~/.config/starship.toml${reset}', if it exists."
            rm "$HOME"/.config/starship.toml 2>/dev/null
            ;;

        rounded)
            msg_info "Using the rounded preset."
            cp starship/rounded.toml "$HOME"/.config/starship.toml
            ;;

        plain)
            msg_info "Using the plain text preset."
            msg_note "You will not need a nerd font for this preset."
            cp starship/plain-text-symbols.toml "$HOME"/.config/starship.toml
            ;;

        rxyhn)
            msg_info "Using rxyhn's Starship prompt. Nice."
            cp starship/nord-starship.toml "$HOME"/.config/starship.toml
            ;;

        skip | *)
            msg_info "Skipping copying a Starship prompt."
            ;;

        esac

        msg_success "Done copying Starship prompts."

    else
        msg_info "Not copying any configs."

    fi

    return
}

# --- Help menu ---
function usage() {
    ## Prints usage for script

    msg_error "Bad argument: '$*' "
    msg_info "Script usage: './shell-install.sh ${blue}ARGUMENT${reset}' \n"

    echo -e "${bold}Possible agruments:${reset}"
    echo -e "${blue}${bold}all${reset}       ->     ${cyan}Run all functions:"
    echo -e "                 (Install dependencies/ZSH plugins -> backup current configs -> overwrite configs)${reset}"

    echo -e "${blue}${bold}zsh${reset}       ->     ${cyan}Just install ZSH plugins and dependencies${reset}"

    echo -e "${blue}${bold}fonts${reset}     ->     ${cyan}Just install fonts"

    echo -e "${blue}${bold}backup${reset}    ->     ${cyan}Just backup user's current configs (htop, kitty, neofetch, starship prompt)${reset}"

    echo -e "${blue}${bold}overwrite${reset} ->     ${cyan}Just overwrite user's current configs with the ones in this repo${reset}"

    echo -e "${blue}${bold}info${reset}      ->     ${cyan}Print some basic info of this machine${reset}"

    echo -e "${blue}${bold}help${reset}      ->     ${cyan}Print this menu${reset} \n"

    return 255
}

# --- Read arguments passed ---
case $1 in
init)
    # This just runs init() to test it initalizes correctly.
    # This argument does nothing important, therefore is hidden from the normal user
    init
    ;;

all)
    init
    sleep 2
    info
    dependencies
    install_zsh
    install_fonts
    backup
    overwrite
    ;;

info)
    init &>/dev/null
    info
    ;;

zsh)
    init
    sleep 2
    info
    dependencies
    install_zsh
    install_fonts
    ;;

fonts)
    init
    sleep 2
    info
    install_fonts
    ;;

backup)
    init
    sleep 2
    info
    backup
    ;;

overwrite)
    init
    sleep 2
    info
    overwrite
    ;;

help | *)
    init &>/dev/null
    usage "$@"
    ;;

esac
