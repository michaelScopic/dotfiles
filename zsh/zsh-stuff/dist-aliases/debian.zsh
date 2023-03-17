# >== Useful aliases for Debian/Ubuntu ==<

# Written by: michaelScopic (https://github.com/michaelScopic)

# - apt-get aliases -
alias up="sudo apt-get update; sudo apt-get upgrade"
alias full-up="sudo apt-get update; sudo apt-get full-upgrade"
alias in-pkg="sudo apt-get install"
alias rm-pkg="sudo apt-get uninstall"
alias autoremove="sudo apt-get autoremove"
alias reinstall="sudo apt-get reinstall"
alias apt-get-sources="sudo apt edit-sources"
alias search-pkg="apt-cache search"
alias show-pkg="apt-cache show"

# - Nala aliases -
## Uncomment this section if you use nala (https://github.com/volitank/nala)
#alias up="sudo nala update; sudo nala upgrade"
#alias in-pkg="sudo nala install"
#alias rm-pkg="sudo nala remove"
#alias search-pkg="nala search"
#alias apt-get-mirrors="sudo nala fetch"

# - Alias to edit this file -
alias debian-aliases="$EDITOR ~/.config/zsh/dist-aliases/debian.zsh"
