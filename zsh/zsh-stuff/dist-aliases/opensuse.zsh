# >== Useful aliases for OpenSUSE ==<

# Written by: michaelScopic (https://github.com/michaelScopic/)

# - Installing/updating -
alias up="sudo zypper up"
alias install="sudo zypper in"
alias dup="sudo zypper dup"
alias zypp-verify="sudo zypper verify"
alias purge-kernels="sudo zypper purge-kernels"

# - Quererying -
alias pkg-search="zypper se"
alias pkg-info="zypper if"
alias what-provides="zypper wp"

# - Misc -
alias zypp-ref="sudo zypper ref -f"
alias zypp-clean="sudo zypper cc; sudo zypper cl"
alias zypp-mirrors="sudo mirrorsorcerer -x && sudo zypper ref -f"

