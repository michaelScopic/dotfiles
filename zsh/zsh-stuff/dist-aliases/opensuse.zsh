# >== Useful aliases for OpenSUSE ==<

# Written by: michaelScopic (https://github.com/michaelScopic/)

# - Installing/updating -
alias up="sudo zypper ref && sudo zypper up"
alias dup="sudo zypper ref && sudo zypper dup"
alias in-pkg="sudo zypper in"
alias rm-pkg="sudo zypper rm"
alias zypp-verify="sudo zypper verify"
alias purge-kernels="sudo zypper purge-kernels"

# - Querying -
alias search-pkg="zypper se"
alias info-pkg="zypper if"
alias what-provides="zypper wp"

# - Misc -
alias zypp-ref="sudo zypper ref -f"
alias zypp-clean="sudo zypper cc; sudo zypper cl"
alias zypp-mirrors="sudo mirrorsorcerer -x && sudo zypper ref -f"

# - Alias to edit this file -
alias opensuse-aliases="$EDITOR ~/.config/zsh/dist-aliases/opensuse.zsh"
