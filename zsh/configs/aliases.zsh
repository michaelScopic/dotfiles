#            _              _  _
#  ____ ___ | |__     __ _ | |(_)  __ _  ___   ___  ___
# |_  // __|| '_ \   / _` || || | / _` |/ __| / _ \/ __|
#  / / \__ \| | | | | (_| || || || (_| |\__ \|  __/\__ \
# /___||___/|_| |_|  \__,_||_||_| \__,_||___/ \___||___/
#
### Written by: michaelScopic (https://github.com/michaelScopic)


#### Set directory for distro specific aliases
DISTRO_ALIAS_DIR="$HOME/.config/zsh/distro-aliases"


#### Uncomment to expand aliases as you type them
#bindkey -- ' ' exp_alias


#### - Dynamic settings -
## Determine to use icons
EZA_OPTS="--icons --group-directories-first -hg --classify=auto" 

## Set an ssh alias if terminal is kitty
[ "$TERM" == "xterm-kitty" ] &&
    alias ssh="kitty +kitten ssh"
    
## Automatically use podman if it is installed
[ "$(command -v podman >/dev/null)" ] &&
  alias docker="podman"

#### - File/directories -
alias ls="eza $EZA_OPTS"
alias la="eza -a $EZA_OPTS"
alias ll="eza -la $EZA_OPTS"
alias rm="rm -iv"
alias cp="cp -iv"
alias mv="mv -iv"
alias grep="grep --color=auto"


#### - Booting/GRUB -
alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias grub-config="sudo grub-configurator"
alias edit-fstab="sudo $EDITOR /etc/fstab"
alias cum="echo -e 'System rebooting...\nGoodbye!'; sudo reboot"
alias kys="echo -e 'System shutting down...\nGoodbye!'; sudo shutdown now"


#### - Config editing -
alias zshrc="$EDITOR ~/.zshrc"
alias zsh-aliases="$EDITOR ~/.config/zsh/aliases.zsh"
alias ls-aliases="cat ~/.config/zsh/aliases.zsh"
alias zsh-functs="$EDITOR ~/.config/zsh/user-functions.zsh"
alias kitty-config="$EDITOR ~/.config/kitty/kitty.conf"


#### - Networking -
alias virt-man_net_start="sudo virsh net-start default" ## <- For virt-manager
alias nmcli="nmcli -p"                                  ## <- Make nmcli pretty
alias ip="ip -c"                                        ## <- Give 'ip' color
alias nm-stat="nmcli dev status"
alias ls-wifi="nmcli dev wifi list"
alias wifi-restart="nmcli radio wifi off && nmcli radio wifi on"
alias wifi-off="nmcli radio wifi off"
alias wifi-on="nmcli radio wifi on"
alias net-restart="sudo nmcli net off && sudo nmcli net on"


#### - Misc. -
alias diff="diff --color=auto"
alias nut="clear; fastfetch"  ## Farewell neofetch 
alias free="free -mth"
alias du="du -h"
alias df="df -h"
alias xrmerge="xrdb -merge ~/.Xresources"
alias reload-sh="exec zsh"
alias exit="echo 'Goodbye!'; sleep 0.2; exit"
alias e="exit"
alias quit="exit"
alias bye="exit"

#### - Distro aliases -
#source "$DISTRO_ALIAS_DIR/opensuse.zsh"	## For OpenSUSE TW
#source "$DISTRO_ALIAS_DIR/debian.zsh"	## For Debian/Ubuntu
#source "$DISTRO_ALIAS_DIR/archLinux.zsh"	## For Arch Linux
#source "$DISTRO_ALIAS_DIR/rhel.zsh"		## For Fedora/RHEL
