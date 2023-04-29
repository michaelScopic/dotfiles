#!/usr/bin/env bash

###########
# Written by: michaelScopic (https://github.com/michaelScopic)
# 
# Requirements: bash, rsync, coreutils
###########

# shellcheck disable=SC2145

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

  # - Set message functions -
  msg_info() {
    echo -e "${cyan}${bold}[ INFO ]${reset} $@ ${reset}"
  }

  msg_error() {
    echo -e "${red}${bold}[ ERROR ]${reset} $@ ${reset}"
  }

  msg_success() {
    echo -e "${green}${bold}[ SUCCESS ]${reset} $@ ${reset}"
  }

  msg_warn() {
    echo -e "${yellow}${bold}[ WARNING ]${reset} $@ ${reset}"
  }

  msg_note() {
    echo -e "${blue}${bold}[ NOTE ]${reset} $@ ${reset}"
  }

  msg_fatal() {
    echo -e "${red}${bold}[ FATAL ]${reset} $@ ${reset}"
  }

  msg_success "Done setting colors and message functions."

  # - Source /etc/os-release -
  if [ -f /etc/os-release ]; then
    . /etc/os-release
    msg_success "Found and sourced '${cyan}/etc/os-release${reset}'."
  else
    msg_error "Could not find '${cyan}/etc/os-release${reset}'."
    msg_error "Unable to source '${cyan}/etc/os-release${reset}'."
  fi

  # - Store user's current dir as a var -
  CURRENT_DIR=$(pwd)
  BUILD_DIR="$HOME/.build_tmp"
  DOTFILES_DIR=$(realpath "$0" | rev | cut -d '/' -f 2- | rev)
  BACKUP_FORMAT=$(date +%F_%I-%M-%S-%p)

  echo -e "-> Current directory: ${cyan}$CURRENT_DIR${reset}"
  echo -e "-> Dotfiles directory: ${cyan}$DOTFILES_DIR${reset}"
  echo -e "-> Backup format: ${cyan}$BACKUP_FORMAT${reset}"

  msg_note "A temporary directory will be made in '${cyan}$BUILD_DIR${reset}' if needed."

  if [ "$DOTFILES_DIR" = '' ]; then
    msg_fatal "${bold}--------------------------------------------"
    msg_fatal "${bold}--${reset} ${red}FATAL: ${cyan}\$DOTFILES_DIR${reset} could not be set. ${reset}${bold}--"
    msg_fatal "${bold}--------------------------------------------"
    msg_note "You may need to install ${blue}binutils${reset} using your package manager."
    msg_fatal "${yellow}init()${reset} has returned exit code 1. \n"
    msg_fatal "Initalization has completed with errors. Aborting!"
    sleep 1.5
    return 1
  fi

  if [ "$SERVER_PRESET" == "TRUE" ]; then
    msg_info "Using the server preset. This uses minimal settings and is non-interactive."
    msg_warn "This answers 'yes' to all questions, which can result in overwriting the following files/directories:"
    echo -e "\
    '${cyan}~/.zshrc${reset}'
    '${cyan}~/.config/zsh/${reset}'
    '${cyan}~/.config/htop/${reset}'
    '${cyan}~/.config/starship.toml${reset}' (If it exists)"
    msg_warn "Proceed with caution. You have been warned."
    sleep 2
  fi

  # - Finish up -
  msg_success "Done initallizing! \n"

  return
}

######################
# --- Print info --- #
######################
function info() {
  # --- Print out basic info about system ---
  echo -e "${bold}---------- Basic info ----------${reset}"
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
}

################################
# --- Install dependencies --- #
################################
function dependencies() {
  # Test if host is running Linux AND the cpu is x86_64 (amd64) based
  if [[ $(uname -s) != "Linux" ]] || [[ $(uname -m) != "x86_64" ]]; then
    # If host is not Linux based and CPU is not x86_64, then print an error.
    # BSD or Darwin hosts or hosts that are not x86 will encounter this.
    msg_error "Detected OS is ${bold}not${reset} x86_64 Linux."
    msg_error "There is no support for BSD or Darwin (MacOS) hosts."
    msg_error "There is no support for Linux hosts that aren't x86_64 (amd64)."
    msg_error "You will need to install the dependencies yourself. \n"
    sleep 3
    return 1
  fi

  #
  # -- SERVER INSTALLATION --
  #
  if [ "$SERVER_PRESET" == "TRUE" ]; then
    echo -e "\
    #############################################
    # ${bold}${blue}             INSTALLING PACKAGES         ${reset} #
    #                                           # 
    # The following packages will be installed: #
    #  ${cyan} git ${reset}                                    #
    #  ${cyan} htop ${reset}                                   # 
    #  ${cyan} zsh ${reset}                                    #
    #  ${cyan} curl ${reset}                                   #
    #  ${cyan} wget ${reset}                                   #
    #  ${cyan} fzf ${reset}                                    #
    #  ${cyan} exa ${reset}                                    #
    #  ${cyan} vim ${reset}                                    #
    #  ${cyan} grc ${reset}                                    #
    #  ${cyan} starship ${reset}                               #
    #############################################"

    if command -v apt-get >/dev/null; then
      # Test if package manager is 'apt-get', for Debian/Ubuntu distros
      msg_info "Found Debian/Ubuntu.\n"
      sudo apt-get install --no-install-recommends -y git htop neofetch zsh curl wget fzf exa unzip vim grc
      ## 'rsync' isn't installing when put in the above line, installing it seperately
      sudo apt-get install -y rsync

      # Installing lsd/exa
      ## LSD/exa sometimes isnt in official repos (depending on distro), so just manually install the .deb files
      ## Downside of doing it this way is that the .deb files might not be the most recent ones
      msg_info "Making a temporary build directory..."
      mkdir "${BUILD_DIR}" && cd "${BUILD_DIR}"
      # Get the exa .deb files
      wget https://github.com/ogham/exa/releases/download/v0.10.1/exa-linux-x86_64-v0.10.1.zip &>/dev/null &&
        # Install the .deb files
        sudo dpkg -i ./*.deb
      # Installing starship
      msg_info "Installing Starship using the offical installer script..."
      curl -sS https://starship.rs/install.sh >install-starship.sh &&
        chmod +x install-starship.sh &&
        ./install-starship.sh -y
      msg_success "Done installing dependencies! \n"
      msg_info "Done. Removing temporary build directory..."
      rm -vrf "${BUILD_DIR}"
    elif command -v pacman >/dev/null; then
      # Test if 'pacman' is the package manager, for Arch based distros
      msg_info "Found Arch Linux.\n"
      sudo pacman -S --noconfirm starship htop neofetch zsh curl wget git htop fzf exa rsync unzip vim grc
      msg_success "Done installing dependencies! \n"

    elif command -v zypper >/dev/null; then
      # Test if 'zypper' if the pacakge manager, for openSUSE distros
      ## NOTE: some of these packages might not be present/up to date on openSUSE Leap.
      msg_info "Found openSUSE.\n"
      sudo zypper -n install htop neofetch zsh curl wget git fzf exa starship rsync unzip vim grc
      msg_success "Done installing dependencies! \n"

    elif command -v dnf >/dev/null; then
      # Test if 'dnf' is the package manager, for RHEL based systems, like Fedora
      ## NOTE: some of these packages might not be present in offical repos in some server focused distros (eg: CentOS, Rocky, Alma)
      msg_info "Found RHEL/Fedora Linux.\n"
      sudo dnf install -y htop neofetch zsh curl wget git fzf exa rsync unzip vim grc
      # Install starship
      mkdir "${BUILD_DIR}" && cd "${BUILD_DIR}"
      curl -sS https://starship.rs/install.sh >install-starship.sh &&
        chmod +x install-starship.sh &&
        ./install-starship.sh -y
      cd ..
      rm -rvf "${BUILD_DIR}"
      msg_success "Done installing dependencies! \n"

    elif command -v xbps-install >/dev/null; then
      # Test if 'xbps-install' is present, for Void Linux
      msg_info "Found Void Linux.\n"
      sudo xbps-install -Suy htop neofetch zsh curl wget git fzf exa starship rsync unzip vim grc
      msg_success "Done installing dependencies! \n"

    elif command -v nix-env >/dev/null; then
      # Test if 'nix-env' is present, for NixOS or systems that have the Nix package manager
      msg_info "Found NixOS/nixpkgs.\n"
      sudo nix-env -i htop neofetch-unstable zsh curl wget git fzf exa starship rsync unzip vim grc
      msg_success "Done installing dependencies! \n"

    else
      # If above package managers aren't present, then give an error
      msg_error "Unable to detect your package manager!"
      msg_error "You will need to install the dependencies yourself. \n"
      sleep 3
      return 1

    fi

    return 0
  fi

  #
  # -- REGULAR INSTALLATION --
  #
  echo -e "\
    #############################################
    # ${bold}${blue}             INSTALLING PACKAGES         ${reset} #
    #                                           # 
    # The following packages will be installed: #
    #  ${cyan} git ${reset}                                    #
    #  ${cyan} kitty ${reset}                                  #
    #  ${cyan} htop ${reset}                                   # 
    #  ${cyan} neofetch ${reset}                               #
    #  ${cyan} zsh ${reset}                                    #
    #  ${cyan} curl ${reset}                                   #
    #  ${cyan} wget ${reset}                                   #
    #  ${cyan} fzf ${reset}                                    #
    #  ${cyan} exa ${reset}                                    #
    #  ${cyan} vim ${reset}                                    #
    #  ${cyan} grc ${reset}                                    #
    #  ${cyan} starship ${reset}                               #
    #############################################"

  if command -v apt-get >/dev/null; then
    # Test if package manager is 'apt-get', for Debian/Ubuntu distros
    msg_info "Found Debian/Ubuntu.\n"
    sudo apt-get install -y git kitty htop neofetch zsh curl wget fzf exa unzip vim grc
    ## 'rsync' isn't installing when put in the above line, installing it seperately
    sudo apt-get install -y rsync

    # Installing lsd/exa
    ## LSD/exa sometimes isnt in official repos (depending on distro), so just manually install the .deb files
    ## Downside of doing it this way is that the .deb files might not be the most recent ones
    msg_info "Making a temporary build directory..."
    mkdir "$BUILD_DIR"
    cd "$BUILD_DIR"
    # Get the lsd and exa .deb files
    wget https://github.com/ogham/exa/releases/download/v0.10.1/exa-linux-x86_64-v0.10.1.zip &>/dev/null &&
      # Install the .deb files
      sudo dpkg -i ./*.deb &&
      cd "$repoDir"
    msg_info "Done. Removing temporary build directory..."
    rm -vrf "${BUILD_DIR}"

    # Installing starship
    msg_info "Installing Starship using the offical installer script..."
    curl -sS https://starship.rs/install.sh | sh
    msg_success "Done installing dependencies! \n"

  elif command -v pacman >/dev/null; then
    # Test if 'pacman' is the package manager, for Arch based distros
    msg_info "Found Arch Linux.\n"
    sudo pacman -S --noconfirm starship kitty htop neofetch zsh curl wget git htop fzf exa rsync unzip vim grc
    msg_success "Done installing dependencies! \n"

  elif command -v zypper >/dev/null; then
    # Test if 'zypper' if the pacakge manager, for openSUSE distros
    ## NOTE: some of these packages might not be present/up to date on openSUSE Leap.
    msg_info "Found openSUSE.\n"
    sudo zypper -n install kitty htop neofetch zsh curl wget git fzf exa starship rsync unzip vim grc
    msg_success "Done installing dependencies! \n"

  elif command -v dnf >/dev/null; then
    # Test if 'dnf' is the package manager, for RHEL based systems, like Fedora
    ## NOTE: some of these packages might not be present in offical repos in some server focused distros (eg: CentOS, Rocky, Alma)
    msg_info "Found RHEL/Fedora Linux.\n"
    sudo dnf install -y kitty htop neofetch zsh curl wget git fzf exa rsync unzip vim grc
    # Install starship
    curl -sS https://starship.rs/install.sh | sh
    msg_success "Done installing dependencies! \n"

  elif command -v xbps-install >/dev/null; then
    # Test if 'xbps-install' is present, for Void Linux
    msg_info "Found Void Linux.\n"
    sudo xbps-install -Suy kitty htop neofetch zsh curl wget git fzf exa starship rsync unzip vim grc
    msg_success "Done installing dependencies! \n"

  elif command -v nix-env >/dev/null; then
    # Test if 'nix-env' is present, for NixOS or systems that have the Nix package manager
    msg_info "Found NixOS/nixpkgs.\n"
    sudo nix-env -i kitty htop neofetch-unstable zsh curl wget git fzf exa starship rsync unzip vim grc
    msg_success "Done installing dependencies! \n"

    # - Show user how to change their default shell in NixOS -
    msg_note "You might need to edit '${cyan}/etc/nixos/configuration.nix${reset}' and change your default shell to zsh."
    echo -e "#--- Example (/etc/nixos/configuration.nix) --- 
    users.users.alice = {
      isNormalUser = true;
      extraGroups = [ \"wheel\" ];
      shell = ${green}pkgs.zsh${reset}; ${bold}# <-- Change shell here${reset}
      packages = with pkgs; [ 
      ];
    };"
    sleep 3

  else
    # If above package managers aren't present, then give an error
    msg_error "Unable to detect your package manager!"
    msg_error "You will need to install the dependencies yourself. \n"
    msg_info "Supported package managers are:"
    msg_info "'apt-get', 'pacman', 'zypper', 'dnf', 'xbps-install', and 'nix-env' \n"
    msg_note "Message me on Discord (${purple}Michael_Scopic.zsh#0102${reset}) if you want to request adding support for another package manager.\n"
    msg_info "Required packages are:"
    msg_info "zsh curl wget git fzf exa lsd rsync unzip\n"
    msg_info "Optional packages:"
    msg_info "neofetch kitty vim \n"

    sleep 2
    return 1

  fi

}

#########################
# --- Install fonts --- #
#########################
function install_fonts() {
  local choice

  if [ "$SERVER_PRESET" == "TRUE" ]; then
    msg_info "Server preset does not install fonts. Skipping...\n"
    return 0
  fi

  read -rp "Do you want to install fonts? [Y/n]: " choice

  if [ "${choice,,}" == "n" ]; then
    msg_info "Answered 'no'. Will NOT install fonts..."
    return 0
  fi

  msg_note "Installing fonts into '${cyan}~/.fonts/${reset}'"
  cd "$DOTFILES_DIR"

  sleep 2
  if [ ! -d "$HOME/.fonts" ]; then
    # Check if '~/.fonts' exist. If it doesn't exist, create it
    msg_info "'${cyan}~/.fonts${reset}' does not exist yet, fixing that."
    mkdir -v "$HOME/.fonts"
  fi

  if [ ! "$(cp -rv fonts/* "$HOME/.fonts")" ]; then
    # If copy failed, then tell user
    msg_error "Exit code: $?"
    ## ^ Shellcheck will warn about refering to "$?", this is fine.
    msg_error "Could not copy fonts to '${cyan}~/.fonts/${reset}'."
    msg_error "Command that failed: '${blue}cp -rv fonts/* $HOME/.fonts${reset}' \n"
    return 1
  else
    # If copy was successful, then tell user then refresh font cache
    msg_success "Copied fonts! Reloading font cache..."
    msg_info "Running: '${purple}fc-cache -rv${reset}'"

    if command -v fc-cache >/dev/null; then
      # If 'fc-cache' is a command, then reload fonts cache
      fc-cache -rv &&
        msg_success "Finished reloading fonts."
    else
      # If it is not a command, give an error
      msg_error "'${purple}fc-cache${reset}' is not a command... Unable to refresh your fonts. Please log out and log back in again."
      return 1
    fi

  fi
}

###############################
# --- INSTALL ZSH CONFIGS --- #
###############################
function install_zsh() {
  local choice
  cd "$DOTFILES_DIR"

  function clone_plugins() {
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

    # Colorizer
    git clone https://github.com/zpm-zsh/colorize.git ~/.config/zsh/plugins/colorize 2>/dev/null &&
      echo -e "${blue}Finished installing Colorize...${reset}"

    msg_success "Finished installing plugins!"

    cd "$DOTFILES_DIR"
    sleep 1
  }

  #
  # -- SERVER INSTALLATION --
  #
  if [ "$SERVER_PRESET" == "TRUE" ]; then
    if [ ! -d "$HOME/.config/zsh" ]; then
      # If '~/.configs' doesnt exist, create it
      mkdir -vp ~/.config/zsh/{plugins,distro-aliases} &&
        msg_success "Created '${cyan}~/.config/zsh/${reset}'!"
    fi

    clone_plugins

    # Make a copy of user's zshrc and rename it as '.zshrc.bak'
    cp -v "$HOME/.zshrc" "$HOME/.zshrc-$BACKUP_FORMAT.bak" 2>/dev/null

    # Copy the zshrc from this directory to home as '.zshrc'
    cp -v zsh/zshrc "$HOME/.zshrc"

    # Copy configs/ to ~/.config/zsh/
    cp -vr zsh/configs/* "$HOME/.config/zsh/"
    cp -v config/.Xresources "$HOME"

    msg_success "Done copying ZSH configs!\n"

    return 0
  fi

  #
  # -- REGULAR INSTALLATION --
  #
  # Detect if '~/.config/zsh/' already exists
  if [ -d "$HOME/.config/zsh" ]; then
    echo -e "\
    #########################################
    # ${bold}${red}               NOTICE                ${reset} #           
    # '${cyan}~/.config/zsh/${reset}' already exists!      #
    # Do you wish to backip this directory? #
    #########################################"
    read -rp "Backup existing '~/.config/zsh/'? [Y/n]: " choice

    if [ "${backup_zsh,,}" == "y" ] || [ "${backup_zsh}" = '' ]; then
      # Make a copy of user's zshrc and rename it as '.zshrc.bak'
      cp -v "$HOME/.zshrc" "$HOME/.zshrc-$BACKUP_FORMAT.bak" 2>/dev/null
      # Backup .config/zsh/ if exists
      msg_info "Creating a backup of '${cyan}~/.config/zsh/${reset}'."
      mkdir -v "$HOME/.config/zsh-$BACKUP_FORMAT.d.bak"
      cp -r "$HOME/.config/zsh/" "$HOME/.config/zsh-$BACKUP_FORMAT.d.bak/"
    else
      msg_info "Skipping backup of '${cyan}~/.config/zsh/${reset}'."
    fi
  fi

  msg_note "Installing ZSH plugins and configs..."

  if [ ! -d "$HOME/.config/zsh" ]; then
    # If '~/.config/zsh' doesnt exist, create it
    msg_info "'${cyan}~/.config/zsh/${reset} does not exist. Fixing that."
    mkdir -vp ~/.config/zsh/{plugins,distro-aliases} &&
      msg_success "Done creating '${cyan}~/.config/zsh/${reset}'!"
  fi

  msg_info "Continuing to install ZSH plugins..."

  # -- Clone plugins --
  clone_plugins

  # --- Overwrite .zshrc ---
  # make a backup of user's .zshrc and place my .zshrc in their ~/.zshrc
  echo -e "
########################################
# ${red}${bold}Do you want to overwrite your${reset}        #
# ${red}${bold}.zshrc with my zshrc?  ${reset}              #
# ${cyan}I will make a backup of your current ${reset}#
# ${cyan}one called${purple} '~/.zshrc.bak' ${reset}           #
######################################## "

  read -rp "Overwrite? [Y/n]: " zshOverwrite

  if [ "${zshOverwrite,,}" == "y" ] || [ "${zshOverwrite}" = "" ]; then
    # If user answered yes (or pressed enter), run this
    msg_info "Answered 'yes'. Continuing..."

    # Make a copy of user's zshrc and rename it as '.zshrc.bak'
    cp -v "$HOME/.zshrc" "$HOME/.zshrc-$BACKUP_FORMAT.bak" 2>/dev/null

    # Copy the zshrc from this directory to home as '.zshrc'
    cp -v zsh/zshrc "$HOME/.zshrc"

    # Copy configs/ to ~/.config/zsh/
    cp -vr zsh/configs/* "$HOME/.config/zsh/"
    cp -v config/.Xresources "$HOME"
    msg_success "Done copying ZSH configs!\n"

  else
    # If user answered no, then skip overwriting zshrc
    msg_info "Answered 'no'. Skipping overwritting zsh."

  fi

  sleep 1

  # --- Starship prompt ---
  msg_info "Do you want to install Starship using the offical install script?"
  msg_info "Press 'n' if you don't want to install it, or if you already have it installed."

  read -rp "Install starship? [Y/n]: " install_starship

  if [ "${install_starship,,}" == "y" ] || [ "${install_starship}" = "" ]; then
    # If user pressed enter or 'y', we will install starship
    msg_info "User answered 'yes', continuing to install Starship..."
    msg_info "Running command:${purple} curl -sS https://starship.rs/install.sh | sh"
    # Offical install script from https://starship.rs , this is safe.
    curl -sS https://starship.rs/install.sh | sh
  else
    msg_info "User answered 'no', skipping installation of Starship."
  fi

}

##########################
# --- BACKUP CONFIGS --- #
##########################
function backup() {
  #
  # -- SERVER INSTALLATION --
  #
  if [ "$SERVER_PRESET" == "TRUE" ]; then
    if [ -d "$HOME"/.config/htop ]; then
      ## If htop config dir exists, backup that
      mkdir -v "$HOME/.config/htop/backups/" 2>/dev/null
      cp -v "$HOME/.config/htop/htoprc" "$HOME/.config/htop/backups/htoprc-$BACKUP_FORMAT.bak"

      msg_success "A backup of htop is in: ${cyan}~/.config/htop/backups/htoprc-$BACKUP_FORMAT.bak${reset} \n"
      sleep 1

    else
      ## If htop config dir isn't found, skip the backup
      msg_error "Unable to find '${cyan}~/.config/htop/${reset}', skipping backup. \n"
      sleep 1

    fi

    # -- Backup starship config --
    msg_info "Attempting to backup Starship..."
    sleep 1

    if [ -f "$HOME"/.config/starship.toml ]; then
      ## If 'starship.toml' exists, back it up.
      cp -v "$HOME"/.config/starship.toml "$HOME/.config/starship.toml.$BACKUP_FORMAT.bak" &&
        msg_success "A backup of your current starship config is in:${cyan} ~/.config/starship.toml.$BACKUP_FORMAT.bak \n"
      sleep 1
    else
      ## If 'starship.toml' doesn't exist, skip it
      msg_error "Unable to find '${cyan}~/.config/starship.toml${reset}', skipping."
      msg_note "If you aren't using Starship, or if you're using the default Starship prompt, this is safe to ignore. \n"
      sleep 1
    fi

    msg_success "Finished backing up everything!"
    sleep 1

    return

  fi

  #
  # -- REGULAR INSTALLATION --
  #
  echo -e "\
  ################################
  # ${bold}${yellow}           BACKUP           ${reset} #
  # Attempting to backup the     #
  # following files/directories: # 
  #   '${cyan}~/.config/htop/${reset}'          #
  #   '${cyan}~/.config/kitty/${reset}'         #
  #   '${cyan}~/.config/neofetch/${reset}'      #  
  #   '${cyan}~/.config/starship.toml${reset}'  #
  ################################\n"

  # -- Backup htop config --
  msg_info "Attempting to backup htop..."
  sleep 1

  if [ -d "$HOME"/.config/htop ]; then
    ## If htop config dir exists, backup that
    mkdir -v "$HOME/.config/htop/backups/" 2>/dev/null
    cp -v "$HOME/.config/htop/htoprc" "$HOME/.config/htop/backups/htoprc-$BACKUP_FORMAT.bak"

    msg_success "A backup of htop is in: ${cyan}~/.config/htop/backups/htoprc-$BACKUP_FORMAT.bak${reset} \n"
    sleep 1

  else
    ## If htop config dir isn't found, skip the backup
    msg_error "Unable to find '${cyan}~/.config/htop/${reset}', skipping backup. \n"
    sleep 1

  fi

  # -- Backup kitty config --
  msg_info "Attempting to backup kitty..."
  sleep 1

  if [ -d "$HOME/.config/kitty/" ]; then
    ## Backup if kitty config dir exists; some people might not have kitty already installed

    mkdir -v "$HOME/.config/kitty/backups/$BACKUP_FORMAT" 2>/dev/null

    ## Using rsync bc cp doesn't have a '--exclude' option to prevent the backups dir to copy into itself
    #cp -v "$HOME"/.config/kitty "$HOME"/.config/kitty/backups && \
    rsync -av --exclude='backups' "$HOME"/.config/kitty/ "$HOME/.config/kitty/backups/$BACKUP_FORMAT" &&
      msg_success "A backup of kitty is in:${cyan} ~/.config/kitty/backups/$BACKUP_FORMAT \n"

    sleep 1

  else
    ## If kitty config dir isn't found, skip the backup
    msg_error "Unable to find '${cyan}~/.config/kitty/${reset}', skipping backup."
    msg_note "${blue}rsync${reset} is need to backup kitty! \n"
    sleep 1

  fi

  # -- Backup neofetch config --
  msg_info "Attempting to backup neofetch..."
  sleep 1

  if [ -d "$HOME"/.config/neofetch ] && [ "$(command -v rsync >/dev/null)" ]; then
    ## If neofetch config dir exists, make a backup
    mkdir -v "$HOME/.config/neofetch/backups/$BACKUP_FORMAT"

    ## Using rsync bc cp doesn't have a '--exclude' option to prevent the backups dir to copy into itself
    #cp -rv "$HOME/.config/neofetch" ~/.config/neofetch/backups/ && \
    rsync -av --exclude='backups' "$HOME/.config/neofetch/" "$HOME/.config/neofetch/backups/$BACKUP_FORMAT/" &&
      msg_success "A backup of neofetch configs are in:${cyan} ~/.config/neofetch/backups/$BACKUP_FORMAT \n"

    sleep 1

  else
    ## If neofetch config dir doesn't exist, skip it
    msg_error "Unable to find '${cyan}~/.config/neofetch/${reset}', Skipping."
    msg_error "${blue}rsync${reset} is needed to run this backup.\n"
    sleep 1
  fi

  # -- Backup starship config --
  msg_info "Attempting to backup Starship..."
  sleep 1

  if [ -f "$HOME"/.config/starship.toml ]; then
    ## If 'starship.toml' exists, back it up.
    cp -v "$HOME"/.config/starship.toml "$HOME/.config/starship.toml.$BACKUP_FORMAT.bak" &&
      msg_success "A backup of your current starship config is in:${cyan} ~/.config/starship.toml.$BACKUP_FORMAT.bak \n"
    sleep 1
  else
    ## If 'starship.toml' doesn't exist, skip it
    msg_error "Unable to find '${cyan}~/.config/starship.toml${reset}', skipping."
    msg_note "If you aren't using Starship, or if you're using the default Starship prompt, this is safe to ignore. \n"
    sleep 1
  fi

  msg_success "Finished backing up everything!"
  sleep 1

  return
}

#############################
# --- OVERWRITE CONFIGS --- #
#############################
function overwrite() {
  cd "$DOTFILES_DIR"

  #
  # -- SERVER INSTALLATION --
  #
  if [ "$SERVER_PRESET" == "TRUE" ]; then
    # Overwrite htop and use default starship prompt
    msg_info "=> Overwriting htop config..."
    mkdir -p "$HOME"/.config/htop/ 2>/dev/null
    cp config/htop/htoprc "$HOME"/.config/htop/htoprc &&
      msg_success "Copied over htop config. \n"

    msg_info "=> Using default Starship prompt..."
    rm "$HOME"/.config/starship.toml 2>/dev/null
    msg_success "Done overwriting configs...\n"

    return 0
  fi

  #
  # -- REGULAR INSTALLATION --
  #
  local choice
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

  read -rp "Do you want to continue with overwritting your current configs? [Y\n]: " choice

  if [ "${config_overwrite,,}" == "y" ] || [ "${config_overwrite}" = "" ]; then

    ## Copy htoprc
    read -rp "Do you want to overwrite htop config? [Y/n]: " choice

    if [ "${choice,,}" == "y" ] || [ "${choice}" = "" ]; then
      mkdir -p "$HOME"/.config/htop/ 2>/dev/null
      cp -v config/htop/htoprc "$HOME"/.config/htop/htoprc &&
        msg_success "Copied over htop config. \n"
      sleep 1
    else
      msg_info "Skipping overwriting htop. \n"
    fi

    ## Copy kitty config
    read -rp "Do you want to overwrite kitty config? [Y/n]: " choice

    if [ "${choice,,}" == "y" ] || [ "${choice}" = "" ]; then
      mkdir -p "$HOME"/.config/kitty/ 2>/dev/null
      cp -rv config/kitty/* "$HOME"/.config/kitty/ &&
        msg_success "Copied over kitty configs. \n"
      sleep 1
    else
      msg_info "Skipping overwriting kitty configs. \n"
    fi

    ## Copy neofetch
    read -rp "Do you want to overwrite neofetch config? [Y/n]: " choice

    if [ "${choice,,}" == "y" ] || [ "${choice}" = "" ]; then
      mkdir -p "$HOME"/.config/neofetch/ 2>/dev/null
      cp -v config/neofetch/config.conf "$HOME"/.config/neofetch/ &&
        msg_success "Copied over neofetch configs. \n"
      sleep 1
    else
      msg_info "Skipping overwriting neofetch configs. \n"
    fi

    ## Copy starship
    msg_info "Copying a Starship prompt."
    msg_note "All of these prompt presets will need a patched nerd font (except for the 'plain' preset). \n"
    msg_note "Running '${purple}./shell-install.sh fonts${reset}' or '${purple}./shell-install.sh all${reset}' will install the nerd fonts for you."
    msg_note "Alternatively, you can install your own fonts manually by visiting: ${blue}https://nerdfonts.com/${reset} \n"

    read -rp "What starship prompt do you want to use? [default/rounded/rxyhn/plain/michael/skip] (default: skip): " choice

    case ${choice,,} in
    default)
      msg_info "Using the default Starship prompt."
      msg_note "This will remove '${cyan}~/.config/starship.toml${reset}', if it exists."
      rm "$HOME"/.config/starship.toml 2>/dev/null
      ;;

    rounded)
      msg_info "Using the rounded preset."
      cp config/starship/rounded.toml "$HOME"/.config/starship.toml
      ;;

    plain)
      msg_info "Using the plain text preset."
      msg_note "You will not need a nerd font for this preset."
      cp config/starship/plain-text-symbols.toml "$HOME"/.config/starship.toml
      ;;

    rxyhn)
      msg_info "Using rxyhn's Starship prompt."
      cp config/starship/rxyhn.toml "$HOME"/.config/starship.toml
      ;;

    michael)
      msg_info "Using my custom prompt. Nice. :)"
      cp config/starship/michael.toml "$HOME"/.config/starship.toml
      ;;

    skip | *)
      msg_info "Will NOT copy a Starship prompt."
      ;;

    esac

    msg_success "Done copying Starship prompts. \n"

  else
    msg_info "Not copying any configs. \n"

  fi

  return
}

####################
# --- HELP MENU--- #
####################
function usage() {
  ## Prints usage for script

  msg_fatal "Bad argument/option: '${yellow}$*${reset}'. Cannot continue."
  msg_info "Script usage: '${green}./shell-install.sh ${blue}ARGUMENT${reset} ${purple}OPTIONS${reset}' \n"

  echo -e "\
Valid ${blue}${bold}ARGUMENTS${reset}:
--------------------------------------------------
| ${blue}info${reset}      | ${bold}Print out basic info.${reset}              |
| ${blue}zsh${reset}       | ${bold}Install ZSH configs and plugins.${reset}   |
| ${blue}fonts${reset}     | ${bold}Install fonts.${reset}                     |
| ${blue}backup${reset}    | ${bold}Backup current configs.${reset}            |
| ${blue}overwrite${reset} | ${bold}Overwrite configs.${reset}                 |
| ${blue}all${reset}       | ${bold}Run all above arguments in one go.${reset} |
| ${blue}help${reset}      | ${bold}Print this help menu.${reset}              |
--------------------------------------------------
| ${blue}init${reset}      | ${bold}Just run the initalizer.${reset}           |
|           | ${bold}Only useful for development.${reset}       |
--------------------------------------------------

Valid ${purple}${bold}OPTIONS${reset}:
-------------------------------------
| ${purple}--server${reset} | ${bold}Use the server preset.${reset} |
|          | ${bold}Minimal settings.${reset}      |
-------------------------------------
  
${bold}NOTE:${reset} The ${purple}option${reset} ${bold}must${reset} be at the very end of your command.
      Eg: '${green}./shell-install.sh ${blue}--server ${purple}all${reset}' ${bold}# <- INCORRECT${reset}
          '${green}./shell-install.sh ${purple}all ${blue}--server${reset}' ${bold}# <- CORRECT${reset}
  
${bold}Project maintained/written by:${reset} 
  ${purple}michaelScopic${reset} (${cyan}https://github.com/michaelScopic${reset})
  "
  return 255
}


#################################
# --- Read arguments passed --- #
#################################
# TODO: make this not ugly as shit
## Enable or disable the server preset
case $2 in
--server)
  declare -r SERVER_PRESET="TRUE"
  ;;

--help | -h)
  init &>/dev/null
  usage "$@"
  ;;
esac

case $1 in
init)
  # This just runs init() to test it initalizes correctly.
  init
  echo "Exit code: $?"
  ;;

all)
  init
  info
  sleep 2
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
  info
  sleep 2
  dependencies
  install_zsh
  install_fonts
  ;;

fonts)
  init
  info
  sleep 2
  install_fonts
  ;;

backup)
  init
  info
  sleep 2
  backup
  ;;

overwrite)
  init
  info
  sleep 2
  overwrite
  ;;

help | *)
  init &>/dev/null
  usage "$@"
  ;;

esac
