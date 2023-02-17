#### ==> ZSH ALIASES <== ####

### Written by: michaelScopic (https://github.com/michaelScopic)

DISTRO_ALIAS_DIR="$HOME/.config/zsh/dist-aliases" ## <- Directory for distro-specific aliases

#### Uncomment below to expand aliases as you type them
#bindkey -- ' ' exp_alias
## eg: typing 'ls' then pressing space will make it appear as 'exa $EXA_OPTIONS'

#### --- Set aliases according to terminal ---
if [ -t 0 ]; then
    ## If terminal is a psudo-terminal/terminal emulator, then use icons
    export EXA_OPTIONS="--icons --group-directories-first -hFg"
else
    ## If terminal is attacted to /dev/tty*, then do not use icons
    export EXA_OPTIONS="--group-directories-first -hFg"
fi

if [ "$TERM" == "xterm-kitty" ]; then
    ## If terminal is Kitty, set a ssh alias
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
alias edit-fstab="sudo vim /etc/fstab"
alias cum="echo -e 'System rebooting...\nGoodbye!'; sudo reboot"
alias kys="echo -e 'System shutting down...\nGoodbye!'; sudo shutdown now"

#### - Config editing -
alias zshrc="vim ~/.zshrc"
alias zsh-aliases="vim ~/.config/zsh/aliases.zsh"
alias ls-aliases="cat ~/.config/zsh/aliases.zsh"
alias zsh-functs="vim ~/.config/zsh/user-functions.zsh"
alias kitty-config="vim ~/.config/kitty/kitty.conf"
alias chadwmrc="vim ~/.config/chadwm/scripts/run.sh"
alias chadwm-config="vim ~/.config/chadwm/chadwm/config.def.h"

#### - Networking -
alias virt-man_net_start="sudo virsh net-start default" ## <-- For virt-manager
alias nmcli="nmcli -p"                                  ## <- Make nmcli pretty
alias ip="ip -c"
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
