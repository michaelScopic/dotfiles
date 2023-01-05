# --- User aliases --- 

# --- Set alias files dir ---
distAliasDir="$HOME/.zsh-stuff/dist-aliases"

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
alias cum="sudo reboot"
alias kys="sudo shutdown now"

# - Config editing related aliases -
alias zshrc="$EDITOR ~/.zshrc"
alias zsh-aliases="$EDITOR ~/.zsh-stuff/aliases.zsh"
alias ls-aliases="cat ~/.zsh-stuff/aliases.zsh"
alias zsh-functs="$EDITOR ~/.zsh-stuff/user-functions.zsh"

# - Misc. aliases -
alias nut="clear; neofetch"
alias ssh="kitty +kitten ssh"
alias virt-man_net_start="sudo virsh net-start default" 
alias free="free -mt"

# - Distro aliases - 
## Comment out the distros that you dont use
source "$distAliasDir/opensuse.zsh"
#source "$distAliasDir/debian.zsh"
#source "$distAliasDir/archLinux.zsh"
