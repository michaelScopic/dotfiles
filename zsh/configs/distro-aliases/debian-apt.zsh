# >== Useful aliases for Debian/Ubuntu ==<

# Written by: michaelScopic (https://github.com/michaelScopic)

#### Set directory for distro specific aliases
DISTRO_ALIAS_DIR="$HOME/.config/zsh/distro-aliases"

if [[ ! "$(command -v nala >/dev/null)" ]]; then
  # - apt-get aliases -
  alias up="sudo apt-get update; sudo apt-get upgrade"
  alias full-up="sudo apt-get update; sudo apt-get full-upgrade"
  alias in-pkg="sudo apt-get install"
  alias rm-pkg="sudo apt-get uninstall"
  alias autoremove-pkg="sudo apt-get autoremove"
  alias reinstall-pkg="sudo apt-get reinstall"
  alias apt-sources="sudo apt edit-sources"
  alias search-pkg="apt-cache search"
  alias show-pkg="apt-cache show"
else
  source "$DISTRO_ALIAS_DIR/debian-nala.zsh"
fi