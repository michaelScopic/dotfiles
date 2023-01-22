# Changelog

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
    - Only tests for Linux OS AND x86_64 (amd64) platforms.
