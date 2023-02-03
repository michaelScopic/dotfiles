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

This was also a perfect oppurtunity to learn Bash/Shell scripting.

## Disclamer

I'm _kinda_ experienced in Bash/Shell scripting, but I'm still learning and getting the hang of stuff, so my code probably won't be the sexiest or most efficient.

## Features

Shell script features:

- _Lots_ of colors
- Interactive
- Automation for deploying dotfiles:
  - Installs needed dependencies (on supported distros)
  - Installs ZSH plugins and then backup and overwrite user's zshrc
  - Backs up user's current configs (in case they want to rollback)
  - Overwrites user's configs with the ones in this repo

## TODO

- [x] Depricate `deploy.sh.bak` and `scripts/`
  - [x] Remove `deploy.sh.bak` and `scripts/` 
- [x] Make everything a function in `shell-install.sh`
- [x] Make functions for printing info/notes, errors, and success messages
- [x] Detect if user is running x86_64 Linux in `install_deps()`, and give an error if both aren't detected
- [x] Add fonts
  - [x] Auotmate installing fonts in `shell-install.sh`
- [x] `shell-install.sh` _<- Successor to `deploy.sh`_
- [x] Add support for NixOS

### Preview pics

- [x] htop
- [x] starship
- [x] kitty
- [x] neofetch

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

- [x] `zsh-stuff/`
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

Look at the possible agruments to use in the script by running:

- (cd into the dotfiles directory if you aren't already there)

```sh
./shell-install help

# Not putting in an argument will do the same
./shell-install
```

You can use these following arguments with this script: `all`, `zsh`, `backup`, `fonts`, `overwrite`, or `info`.

So if you want to run all of them, just do:

```sh
./shell-install all
```

If you don't want to run this script and only copy what you want, then just browse `config/` and/or `zsh/` and do what you want from there.

## Getting help

**Discord: `Michael_Scopic.zsh#0102`**

If you need help or something does not work as expected, please contact me on Discord.

I am almost _always_ online, and I will usually respond very quickly.

- NOTE: If you do contact me, please tell me that you found me from GitHub. I am extremely paranoid of who messages me, especially people I don't know.

## Credits

Thank you [r/unixporn community](https://reddit.com/r/unixporn) for inspiring me to rice desktops.

Nord starship prompt (`config/starship/nord-starship.toml`) is from [rxyhn's dotfiles](https://github.com/rxyhn/dotfiles), and I just tweaked the colors to match with any color scheme.

Rounded starship prompt (`config/starship/rounded.toml`) is from [Syndrizzle's dotfiles](https://github.com/Syndrizzle/hotfiles), and I also tweaked the colors to match with any color scheme.

Plain text starship prompt (`config/starship/plain-text-symbols.toml`) are taken from [Starship's offical prompt presets](https://starship.rs).

All fonts in `fonts/` are from [Nerdfonts.com](https://www.nerdfonts.com).
