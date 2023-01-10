# >== Useful aliases for RHEL based systems ==<

# Written by: michaelScopic (https://github.com/michaelScopic)

# - Installing/updating -
alias up="sudo dnf update"
alias upgrade="sudo dnf upgrade"
alias install="sudo dnf install"
alias uninstall="sudo dnf remove"
alias autoremove="sudo dnf autoremove"
alias reinstall="sudo dnf reinstall"
alias downgrade="sudo dnf downgrade"

# - Querying -
alias what-provides="sudo dnf provides"
alias pkg-search="dnf search"
alias pkg-info="dnf info"

# - Misc -
alias pkg-clean="sudo dnf clean"
alias dnf-regen="sudo dnf makecache"
alias dnf-config="sudo $EDITOR /etc/dnf/dnf.conf"

