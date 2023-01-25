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
alias zsh-aliases="$EDITOR ~/.zsh-stuff/aliases.zsh"
alias ls-aliases="cat ~/.zsh-stuff/aliases.zsh"
alias zsh-functs="$EDITOR ~/.zsh-stuff/user-functions.zsh"
alias kitty-config="$EDITOR ~/.config/kitty/kitty.conf"
alias chadwmrc="$EDITOR ~/.config/chadwm/scripts/run.sh"
alias chadwm-config="$EDITOR ~/.config/chadwm/chadwm/config.def.h"

# - Misc. aliases -
alias nut="clear; neofetch"
alias ssh="kitty +kitten ssh" ## Only for kitty-term, uncomment if you use another terminal
alias virt-man_net_start="sudo virsh net-start default" ## For virt-manager
alias free="free -mt"
alias du="du -h"
alias xmerge="xrdb -merge ~/.Xresources"
alias e="exit"
alias quit="exit"

# - Distro aliases - 
## Uncomment out the distro that you use
#source "$distAliasDir/opensuse.zsh"    ## For OpenSUSE
#source "$distAliasDir/debian.zsh"      ## For Debian/Ubuntu
#source "$distAliasDir/archLinux.zsh"   ## For Arch Linux
#source "$distAliasDir/rhel.zsh"        ## For Fedora/CentOS/RHEL
