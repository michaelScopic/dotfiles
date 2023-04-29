# Changelog

## April 29, 2023

- Updated `README.md`
- Uploaded my custom Starship prompt (`config/starship/michael.toml`)
  - Added prompt as a preset in `shell-install.sh` (named `michael`)
- Uploaded new fonts (Agave and UbuntuMono)
- Updated `kitty.conf` 

## April 14, 2023

- `shell-install.sh`
  - Added a server preset with `--server`
    - Skips installing kitty
    - Skips installing fonts
    - Only backups/overwrites htop and Starship configs
  - Added more messages: `msg_warn` and `msg_fatal`.
    - `msg_warn` just warns user about something
    - `msg_fatal` gives an error to a user and then exits shortly after
  - New help menu

- Renamed directories

  - `.config/` -> `config/`
  - `zsh/zsh-stuff/` -> `zsh/configs/`

- `zshrc`
  - Changed how `zsh-autosuggestions` should complete suggestions

## Feb 10, 2023

- Deprecated `lsd`, fully switched to `exa`
  - Removed `lsd` from being installed in `shell-install.sh`
- Detected if terminal is a tty, and disable using icons if it is a tty

## Feb 6, 2023

- Renamed config dir to `.config/`
  - Updated `shell-install.sh` to account for new name
- Renamed bin dir to `.local/bin/`

## Feb 1, 2023

- Removed `deploy.sh.bak`
- Removed everything in `scripts/`

## Jan 24, 2023

- Renamed variables (look in `init()`)
- Added error handling if certain criteria aren't met:

  - Will throw an error if `/etc/os-release` doesn't exist and will throw another error if `$DOTFILES_DIR` is not set.
  - `init()`:
    - Will throw an error if `/etc/os-release` does not exist.
    - This is non-fatal, so `init()` wont return `1` as the exit code.
    - Will throw an error if `$DOTFILES_DIR` is not set.
      - This is a fatal error, so `init()` will return `1` as exit code.
      - **This error will happen if `rev` is not a command. Setting the value of `$DOTFILES_DIR` relies on `rev`.**
      - The rest of the script can continue, but will not be able to overwrite or copy zsh configs.
  - `install_fonts()`:
    - Will throw an error if `$DOTFILES_DIR` is not set.
      - This is fatal, and this function will not continue.
    - Will throw error if `fc-cache` is not a command.
      - non-fatal, but it doesn't really matter because this command comes at the end of this funciton.
  - `install_zsh()`:
    - Will throw an error if `$DOTFILES_DIR` is not set.
      - This is fatal, and this function will not continue.
      - This is because this function needs to be able to copy files from the dotfiles directory.
  - `overwrite()`:
    - Will throw an error if `$DOTFILES_DIR` is not set.
      - This is fatal, and this function will not continue.
      - This is because function needs to be able to copy files from the dotfiles directory.

- `install_zsh()`

  - Fixed typo to make `~/.config/zsh` if it _does not_ already exists.
    - Origianally detected if it _does_ exists, then makes the directory even though it already exists.

- Planning on completely removing `deploy.sh.bak` and everything in `scripts/`. These scripts have been deprecated, and the functionality of them have been merged into one script (`shell-install.sh`). The new script is basically better in every way.
  - Maybe I'll move these scripts into a `deprecated/` directory? Makes it nice to see how far I've come for Shell scripting. :)

## Jan 20, 2023

- Created `CHANGELOG.md` to track progress.
- `shell-install.sh`
  - Finished functions.
  - Introduced message functions:
    - `msg_info()` <- For showing info to user (ex: `[INFO] Installing dependencies...`)
    - `msg_note()` <- For showing notes to user (ex: `[NOTE] You might need to change your shell to ZSH.`)
    - `msg_error()` <- For printing errors to user (ex: `[ERROR] Unable to detect package manager!`)
    - `msg_success()` <- For printing successes to user (ex: `[SUCCESS] Copied configs.`)
  - Allowed user to just call `init()`. Only useful for making sure the script initalizes as expected. You can just run `init()` with `./shell-install init`
  - Renamed the name of some Starship prompts to give credit to the creators.
  - `dependencies()`
    - Completely revamped package manager detection:
      - Instead of trying to find the distro name with `/etc/os-release`, we just pick up the name of the package managers themselves (eg: `apt-get` for Debian/Ubuntu based sytems, `pacman` for Arch based systems, so on and so on)
      - Gets rid of excess complexity and negates workarounds for distros that have different names in `/etc/os-release`
      - Doesn't require `/etc/os-release`, which might not be present on all distros (especially in containers)
    - Added NixOS/nixpkgs support
    - Only tests for Linux AND x86_64 (amd64) platforms.
      - Will throw an error if detected host is not Linux AND is not x86_64.
      - This would be a fatal error, this function would not be able to continue without knowing the system's package manager.
