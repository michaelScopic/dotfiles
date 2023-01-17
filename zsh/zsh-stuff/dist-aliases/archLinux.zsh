alias pkg-up="sudo pacman -Syu"
alias aur-up="sudo yay -Syu || sudo paru -Syu"
alias mirror-update="sudo reflector --verbose --score 100 -l 50 -f 10 --sort rate --save /etc/pacman.d/mirrorlist"
alias pkg-search="pacman -Qs"

# --- Arch functions ---
keyfix() {
    echo "!!! Fixing pacman keys... !!!"
    sudo rm /var/lib/pacman/sync
    sudo rm -rf /etc/pacman.d/gnupg/*
    sudo pacman-key --init
    sudo pacman-key --populate
    sudo pacman -Syy
    echo "!!! Done. !!!"
}

pkg-full-up() {
    echo "Updating pacman and your AUR helper(s)..."
    sudo pacman -Syyu
    paru -Syyu
    yay -Syyu
    echo "!!! Done. !!!"
}
