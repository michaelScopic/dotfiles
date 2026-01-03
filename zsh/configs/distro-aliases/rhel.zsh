# >== Useful aliases for RHEL based systems ==<

# Written by: michaelScopic (https://github.com/michaelScopic)

# - Installing/updating -
alias up="sudo dnf update"
alias in-pkg="sudo dnf install"
alias rm-pkg="sudo dnf remove"
alias autoremove="sudo dnf autoremove"
alias reinstall="sudo dnf reinstall"
alias downgrade="sudo dnf downgrade"

# - Querying -
alias what-provides="sudo dnf provides"
alias search-pkg="dnf search"
alias info-pkg="dnf info"

# - Misc -
alias dnf-clean="sudo dnf clean"
alias dnf-regen="sudo dnf makecache"
alias dnf-config="sudo $EDITOR /etc/dnf/dnf.conf"

# - Alias to edit this file -
alias rhel-aliases="$EDITOR ~/.config/zsh/distro-aliases/rhel.zsh"
