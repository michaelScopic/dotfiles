#### ==> ZSH ALIASES <== ####

### Written by: michaelScopic (https://github.com/michaelScopic)

#### --- Defualt to nano (for new users) if $EDITOR is not set ---
if [ "$EDITOR" = "" ]; then
    export EDITOR=$(which nano)
    #export EDITOR=$(which vim)
fi

distAliasDir="$HOME/.config/zsh/dist-aliases" ## <- Directory for distro-specific aliases

#### --- Set aliases according to terminal ---
if [ -t 0 ]; then
    ## If terminal is a psudo-terminal/terminal emulator, then use icons
    export EXA_OPTIONS="--group-directories-first --icons -hFg"
else
    ## If terminal is attacted to /dev/tty*, then do not use icons
    export EXA_OPTIONS="--group-directories-first -hFg"
fi

if [ "$TERM" == "xterm-kitty" ]; then
    ## If terminal is Kitty, set a ssh variable
    alias ssh="kitty +kitten ssh"
fi

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
alias virt-man_net_start="sudo virsh net-start default" ## <-- For virt-manager
alias nmcli="nmcli -p"                                  ## <- Make nmcli pretty
alias nm-stat="nmcli dev status"
alias ls-wifi="nmcli dev wifi list"
alias wifi-restart="nmcli radio wifi off && nmcli radio wifi on"
alias wifi-off="nmcli radio wifi off"
alias wifi-on="nmcli radio wifi on"

#### - Misc. -
alias nut="clear; neofetch"
#alias docker="podman" ## <- Uncomment if you use podman
alias free="free -mt"
alias du="du -h"
alias df="df -h"
alias xrmerge="xrdb -merge ~/.Xresources"
alias reload-sh="exec zsh"
alias e="echo 'Goodbye!'; sleep 0.2; exit"
alias quit="echo 'Goodbye!'; sleep 0.2; exit"

#### - Distro aliases -
## Uncomment out the distro that you use
#source "$distAliasDir/opensuse.zsh"    ## <- For OpenSUSE
#source "$distAliasDir/debian.zsh"      ## <- For Debian/Ubuntu
#source "$distAliasDir/archLinux.zsh"   ## <- For Arch Linux
#source "$distAliasDir/rhel.zsh"        ## <- For Fedora/CentOS/RHEL
