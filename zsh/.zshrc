# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# zsh theme
# ZSH_THEME="spaceship"


# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

#### START plugins ####

plugins=(
	git
	zsh-autosuggestions
	zsh-syntax-highlighting
)

#### END plugins ####

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
#if [[ -n $SSH_CONNECTION ]]; then
#  export EDITOR='nvim'
#else
#  export EDITOR='nvim'
#fi

# Compilation flags
export ARCHFLAGS="-arch x86_64"


#### START user aliases ####
alias kys='shutdown now'
alias cum='reboot'
alias grep='grep --color=auto'
alias grub-update='sudo grub-mkconfig -o /boot/grub/grub.cfg'
# alias mirror-update='sudo reflector --verbose --score 100 -l 50 -f 10 --sort rate --save /etc/pacman.d/mirrorlist'	# for arch users
# alias ls='lsd -AF --color=always'	# you need 'lsd' installed for this
alias ls='ls -AF --color=always '
alias nut='clear; neofetch'
alias mv='mv -iv '
alias cp='cp -iv '
alias rm='rm -iv '
#### END user aliases ####


#### START user functions ####

cd() # cd and ls after
{
        builtin cd "$@" && command ls --color=always -AF
}

#### END user functions ####

#### START autostart ####
#eval "$(starship init zsh)"	# You need starship installed for this (https://starship.rs)

#### END autostart ####
