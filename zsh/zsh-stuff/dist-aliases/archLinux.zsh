# >== Useful aliases/functions for Arch Linux ==<

# Written by: michaelScopic (https://github.com/michaelScopic)

alias up="sudo pacman -Syu"
alias aur-up="sudo yay -Syu ; sudo paru -Syu"
alias mirror-update="sudo reflector --verbose --score 100 -l 50 -f 10 --sort rate --save /etc/pacman.d/mirrorlist"
alias pkg-search="pacman -Qs"
alias repo-sync="sudo pacman -Syyy"

# --- Arch functions ---
pacman-keyfix() {
    echo "!!! Fixing pacman keys... !!!"
    sudo rm -v /var/lib/pacman/sync
    sudo rm -vrf /etc/pacman.d/gnupg/*
    sudo pacman-key --init
    sudo pacman-key --populate
    sudo pacman -Syy
    echo "!!! Done. !!!"
}

pkg-full-up() {
    echo "Updating pacman, paru, and yay..." 
    sudo pacman -Syyu
    paru -Syyu
    yay -Syyu
    echo "!!! Done. !!!"
}
