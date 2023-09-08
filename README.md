# My Linux dotfiles

These are my dotfiles for my Linux configs and ZSH.

I hope you enjoy!

## Table of contents

- [Why?](https://github.com/michaelScopic/dotfiles#why)
- [Disclamer](https://github.com/michaelScopic/dotfiles#disclamer)
- [Features](https://github.com/michaelScopic/dotfiles#features)
- [Todo](https://github.com/michaelScopic/dotfiles#todo)
- [Progress](https://github.com/michaelScopic/dotfiles#progress)
- [Installation](https://github.com/michaelScopic/dotfiles#installation-guide)
  - [Install using scripts](https://github.com/michaelScopic/dotfiles#install-using-the-provided-script)
- [Credits](https://github.com/michaelScopic/dotfiles#credits)

## Why?

I wanted to showcase my configs in hopes that someone else can enjoy my work (and stealing from other ppl's dots lmao (credits are at the bottom of this file)).

This was also a perfect opportunity to learn Bash/Shell scripting.

## Disclamer

I'm _kinda_ experienced in Bash/Shell scripting, but I'm still learning and getting the hang of stuff, so my code probably won't be the sexiest or most efficient, but it works.

## Features

Shell script features:

- _Lots_ of colors
- Interactive (and non-interactive with the `--server` option)
- Automation for deploying dotfiles:
  - Installs needed dependencies (on supported distros)
  - Installs ZSH plugins and then backup and overwrite user's zshrc
  - Backs up user's current configs (in case they want to rollback)
  - Overwrites user's configs with the ones in this repo
- Various distro support
  - Debian/Ubuntu and its derivatives
  - Arch Linux and its derivatives
  - Fedora (via `dnf`) and its derivative
  - openSUSE Tumbleweed
  - Void Linux
  - NixOS/nix-pkgs
  - _More coming soon? (maybe)_

## TODO

- [ ] `shell-install.sh`
- [x] Deprecate and delete `deploy.sh.bak` and `scripts/`
  - [x] Make everything a function in `shell-install.sh`
  - [x] Make functions for printing info/notes, errors, and success messages
  - [x] Detect if the user is running x86_64 Linux in `dependencies()`, and give an error if both aren't detected
  - [x] Add fonts and automate installing fonts
  - [x] Add support for NixOS

- [ ] Upload a WM configs
  - [ ] Make a script to automate installing the configs/dependencies

### `config/htop`

- [x] `htoprc`
- [x] `README.md`

### `config/starship`

- [x] `config/starship/rounded.toml`
- [x] `config/starship/plain-text-symbols.toml`
- [x] `README.md`

### `config/neofetch/`

- [x] `config.conf` _<- Neofetch config_
- [x] `README.md`

### `config/kitty/`

- [x] `kitty.conf`
- [x] `themes/` _<- Folder to contain color themes_
  - [x] `darkdecay.ini`
  - [x] `decaycs.ini`
  - [x] `nord.conf` _<- Default theme_
- [x] `README.md`

### `zsh/`

- [x] `configs/`
  - [x] `distro-aliases` _<- Aliases for package management_
    - [x] Arch Linux
    - [x] Debian/Ubuntu
    - [x] openSUSE
    - [x] RHEL/dnf
  - [x] Aliases
  - [x] User functions
  - [x] ZSH settings
- [x] `ArchLabs_zshrc`
- [x] `zshrc`

More coming soon...hopefully.

## Installation guide

### Install using the provided script

Clone the repo:

```sh
git clone https://github.com/michaelScopic/dotfiles

cd dotfiles
```

Look at the possible arguments to use in the script by running:

- (`cd` into the dotfiles directory if you aren't already there)

```sh
./shell-install.sh help

# Not putting in an argument will do the same
./shell-install.sh
```

You can use the following arguments with this script: `all`, `zsh`, `backup`, `fonts`, `overwrite`, or `info`.

So if you want to run all of them, just do:

```sh
./shell-install.sh all
```

If you want to have a more minimal install, pass the `--server` option __at the end__ of the command. 

```sh
./shell-install.sh all --server
```

### Installing manually

If you don't want to run this script and only copy what you want, then just browse `config/` and/or `zsh/` and do what you want from there.

## Getting help

**Discord: `michael_scopic.zsh`**

If you need help or if something does not work as expected, please contact me on Discord.

I am almost _always_ online, and I will usually respond very quickly.

- NOTE: If you do contact me, please tell me that you found me from GitHub. I am extremely paranoid of who messages me, especially for people I don't know.

## Credits

Thank you [r/unixporn community](https://reddit.com/r/unixporn) for inspiring me to rice desktops.

Rxyhn's starship prompt is from [rxyhn's dotfiles](https://github.com/rxyhn/dotfiles), and I just tweaked the colors to match with any color scheme.

Rounded starship prompt (`config/starship/rounded.toml`) is from [Syndrizzle's dotfiles](https://github.com/Syndrizzle/hotfiles), and I also tweaked the colors to match with any color scheme.

Plain text starship prompt (`config/starship/plain-text-symbols.toml`) are taken from [Starship's official prompt presets](https://starship.rs).

All fonts in `fonts/` are from [Nerdfonts.com](https://www.nerdfonts.com).

The original `zshrc` and `zsh/configs/zsh-settings.zsh` are based on the `.zshrc` provided by ArchLabs.
