#            _              _  _
#  ____ ___ | |__     __ _ | |(_)  __ _  ___   ___  ___
# |_  // __|| '_ \   / _` || || | / _` |/ __| / _ \/ __|
#  / / \__ \| | | | | (_| || || || (_| |\__ \|  __/\__ \
# /___||___/|_| |_|  \__,_||_||_| \__,_||___/ \___||___/
#
### Written by: michaelScopic (https://github.com/michaelScopic)


#### Uncomment to expand aliases as you type them
#bindkey -- ' ' exp_alias

#### Set directory for distro specific aliases
DISTRO_ALIAS_DIR="$HOME/.config/zsh/dist-aliases"

#### - Dynamic settings -
## Determine to use icons
[ -t 0 ] &&
    ## Use icons if terminal is not a tty
    EXA_OPTIONS="--icons --group-directories-first -hFg" ||
    ## Don't use icons if terminal is a tty
    EXA_OPTIONS="--group-directories-first -hFg"

## Set an ssh alias if terminal is kitty
[ "$TERM" == "xterm-kitty" ] &&
    alias ssh="kitty +kitten ssh"

#### Default to vim if $EDITOR is not set
[ -z $EDITOR ] &&
    export EDITOR=vim

#### - File/directories -
alias ls="exa $EXA_OPTIONS"
alias la="exa -a $EXA_OPTIONS"
alias ll="exa -la $EXA_OPTIONS"
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
alias chadwmrc="$EDITOR ~/.config/chadwm/scripts/run.sh"
alias chadwm-config="$EDITOR ~/.config/chadwm/chadwm/config.def.h"

#### - Networking -
alias virt-man_net_start="sudo virsh net-start default" ## <- For virt-manager
alias nmcli="nmcli -p"                                  ## <- Make nmcli pretty
alias ip="ip -c"                                        ## <- Give 'ip' color
alias nm-stat="nmcli dev status"
alias ls-wifi="nmcli dev wifi list"
alias wifi-restart="nmcli radio wifi off && nmcli radio wifi on"
alias wifi-off="nmcli radio wifi off"
alias wifi-on="nmcli radio wifi on"

#### - Misc. -
alias nut="clear; neofetch"
#alias docker="podman" ## <- Uncomment if you use podman
alias free="free -mth"
alias du="du -h"
alias df="df -h"
alias xrmerge="xrdb -merge ~/.Xresources"
alias reload-sh="exec zsh"
alias exit="echo 'Goodbye!'; sleep 0.2; exit"
alias e="exit"
alias quit="exit"

#### - Distro aliases -
## Uncomment out the distro that you use
#source "$DISTRO_ALIAS_DIR/opensuse.zsh"    ## <- For OpenSUSE
#source "$DISTRO_ALIAS_DIR/debian.zsh"      ## <- For Debian/Ubuntu
#source "$DISTRO_ALIAS_DIR/archLinux.zsh"   ## <- For Arch Linux
#source "$DISTRO_ALIAS_DIR/rhel.zsh"        ## <- For Fedora/CentOS/RHEL
