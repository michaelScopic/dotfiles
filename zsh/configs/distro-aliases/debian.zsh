# >== Useful aliases for Debian/Ubuntu ==<
#
# Written by: michaelScopic (https://github.com/michaelScopic)
#

# Pass arguments to apt if you want
export APT_OPTS=""
#export APT_OPTS="-y --no-install-recommends" ## Just an example :)

if [ "$(command -v nala >/dev/null)" ]; then
  # - Nala aliases -
  alias up="sudo nala update; sudo nala upgrade $APT_OPTS"
  alias in-pkg="sudo nala install $APT_OPTS"
  alias rm-pkg="sudo nala remove"
  alias search-pkg="nala search"
  alias apt-get-mirrors="sudo nala fetch"
  alias reinstall-pkg="sudo nala reinstall"
  alias autoremove-pkg="sudo nala autoremove"
  alias autopurge-pkg="sudo nala autopurge"
  alias search-pkg="nala search"
  alias show-pkg="nala show"
else
  # - apt-get aliases -
  alias up="sudo apt-get update; sudo apt-get upgrade $APT_OPTS"
  alias full-up="sudo apt-get update; sudo apt-get full-upgrade $APT_OPTS"
  alias in-pkg="sudo apt-get install $APT_OPTS"
  alias rm-pkg="sudo apt-get uninstall"
  alias autoremove-pkg="sudo apt-get autoremove"
  alias reinstall-pkg="sudo apt-get reinstall"
  alias apt-sources="sudo apt edit-sources"
  alias search-pkg="apt-cache search"
  alias show-pkg="apt-cache show"
fi

# - Alias to edit this file -
  alias debian-aliases="$EDITOR ~/.config/zsh/dist-aliases/debian.zsh"