# >== Useful aliases/functions for Arch Linux ==<

# Written by: michaelScopic (https://github.com/michaelScopic)

# - Installing/updating -
alias up="sudo pacman -Syu"
alias aur-up="sudo yay -Syu ; sudo paru -Syu"
alias in-pkg="sudo pacman -S"
alias rm-pkg="sudo pacman -Rns"
alias search-pkg="pacman -Qs"

# - Mirrors -
alias mirror-update="sudo reflector --verbose --score 100 -l 50 -f 10 --sort rate --save /etc/pacman.d/mirrorlist"

# -- Arch functions --
pacman-keyfix() {
  echo -e "=> Fixing pacman keys... \n"
  echo -e "-> Removing '/var/lib/pacman/sync'."
  sudo rm -v /var/lib/pacman/sync
  echo -e "-> Removing '/etc/pacman.d/gnupg/'."
  sudo rm -vrf "/etc/pacman.d/gnupg/*"
  echo -e "-> Initalizing and populating the pacman keyring."
  sudo pacman-key --init
  sudo pacman-key --populate
  echo -e "-> Syncing pacman mirrors."
  sudo pacman -Syy
  echo "=> Done!"
}

pkg-full-up() {
  echo -e "=> Updating pacman...\n"
  sudo pacman -Syu
  echo -e "-> Pacman exit code: $? \n"
  if [ "$(command -v paru >/dev/null)" ]; then
    echo -e "=> Updating paru...\n"
    paru -Syu
    echo -e "-> Paru exit code: $? \n"
  elif [ "$(command -v yay >/dev/null)" ]; then
    echo -e "=> Updating yay...\n"
    yay -Syu
    echo -e "-> Yay exit code: $? \n"
  fi
}

# - Alias to edit this file -
alias arch-aliases="$EDITOR ~/.config/zsh/distro-aliases/archLinux.zsh"
