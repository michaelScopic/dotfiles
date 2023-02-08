# --- User aliases --- 

# Written by: michaelScopic (https://github.com/michaelScopic)

# --- Set alias files dir ---
distAliasDir="$HOME/.config/zsh/dist-aliases"

# - File/directory related aliases -
LS_OPTIONS="--group-dirs=first -hF"
EXA_OPTIONS="--group-directories-first -hF"
alias ls="lsd $LS_OPTIONS" 
alias la="lsd -A $LS_OPTIONS"
alias ll="exa -la $EXA_OPTIONS"
#alias ll="lsd -lAhF"   ## "lsd" alternative for "ll"
alias rm="rm -iv"
alias cp="cp -iv"
alias mv="mv -iv"
alias grep="grep --color=auto"

# - Boot related aliases -
alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias grub-config="sudo grub-configurator"
alias cum="sudo reboot"
alias kys="sudo shutdown now"

# - Config editing related aliases -
alias zshrc="$EDITOR ~/.zshrc"
alias zsh-aliases="$EDITOR ~/.config/zsh/aliases.zsh"
alias ls-aliases="cat ~/.config/zsh/aliases.zsh"
alias zsh-functs="$EDITOR ~/.config/zsh/user-functions.zsh"
alias kitty-config="$EDITOR ~/.config/kitty/kitty.conf"
alias chadwmrc="$EDITOR ~/.config/chadwm/scripts/run.sh"
alias chadwm-config="$EDITOR ~/.config/chadwm/chadwm/config.def.h"

# - Networking -
#alias ssh="kitty +kitten ssh" ## Only for kitty-term, uncomment if you use another terminal
alias virt-man_net_start="sudo virsh net-start default" ## For virt-manager
alias nmcli="nmcli -p"
alias nm-stat="nmcli dev status"
alias ls-wifi="nmcli dev wifi list"
alias wifi-restart="nmcli radio wifi off && nmcli radio wifi on"
alias wifi-off="nmcli radio wifi off"
alias wifi-on="nmcli radio wifi on"

# - Misc. aliases -
alias nut="clear; neofetch"
#alias docker="podman"
alias free="free -mt"
alias du="du -h"
alias df="df -h"
alias xrmerge="xrdb -merge ~/.Xresources"
alias reload-sh="exec zsh"
alias e="echo 'Goodbye!'; sleep 0.2; exit"
alias quit="echo 'Goodbye!'; sleep 0.2; exit"

# - Distro aliases - 
## Uncomment out the distro that you use
#source "$distAliasDir/opensuse.zsh"    ## For OpenSUSE
#source "$distAliasDir/debian.zsh"      ## For Debian/Ubuntu
#source "$distAliasDir/archLinux.zsh"   ## For Arch Linux
#source "$distAliasDir/rhel.zsh"        ## For Fedora/CentOS/RHEL
