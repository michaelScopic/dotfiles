# >== Useful aliases for OpenSUSE ==<

# Written by: michaelScopic (https://github.com/michaelScopic/)

# - Installing/updating -
alias up="sudo zypper dup"
alias dup="sudo zypper dup"
alias install-pkg="sudo zypper in"
alias remove-pkg="sudo zypper rm"
alias zypp-verify="sudo zypper verify"
alias purge-kernels="sudo zypper purge-kernels"

# - Quererying -
alias search-pkg="zypper se"
alias info-pkg="zypper if"
alias what-provides="zypper wp"

# - Misc -
alias zypp-ref="sudo zypper ref -f"
alias zypp-clean="sudo zypper cc; sudo zypper cl"
alias zypp-mirrors="sudo mirrorsorcerer -x && sudo zypper ref -f"

