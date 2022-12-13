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
  - [Install using the wiki](https://github.com/michaelScopic/dotfiles#install-using-the-wiki)
  - [Install using scripts](https://github.com/michaelScopic/dotfiles#install-using-the-provided-script)
- [Contributing](https://github.com/michaelScopic/dotfiles#contributing)
  - [Guidelines](https://github.com/michaelScopic/dotfiles#contributing-guidelines)

## Why?

I wanted to showcase my configs in hopes that someone else can enjoy my work (and stealing from other ppl's dots lmao).

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

- [ ] MacOS support _<- I won't be able to do this as I don't use a Mac, so a PR is appreciated_
  - [ ] Add MacOS support/dependencies in `scripts/dependencies.sh`
- [x] Make overwriting function in `deploy.sh` interactive
- [ ] Add fonts
  - [ ] Auotmate installing fonts in `deploy.sh`

## Progress

### Scripts

- [x] `scripts/info.sh` _<- Prints info about the system it's running on_
- [x] `scripts/init.sh` _<- Initalizer script_
- [x] `scripts/pluginInstall.sh` _<- Installs ZSH plugins, optionally calls `dependencies.sh`_
- [x] `scripts/dependencies.sh` _<- Installs dependencies (on supported distros)_
- [ ] `deploy.sh` _<- Automates everything, calls the above scripts_

### Preview pics

- [x] htop
- [x] starship
- [x] kitty
- [x] neofetch

### `config/htop`

- [x] `htoprc`
- [x] `README.md`

### `starship`

- [x] `config/starship/rounded.toml`
- [x] `config/starship/plain-text-symbols.toml`
- [ ] My own prompt _<- (it's a skid at best, I have no clue what I'm doing)_
- [x] `README.md`

### `config/neofetch/`

- [x] `config.conf` _<- Neofetch config_
- [x] `README.md`

### `config/kitty/`

- [x] `kitty.conf` _<- Kitty config_
- [ ] `themes/` _<- Folder to contain color themes_
  - [x] `darkdecay.ini`
  - [x] `decaycs.ini`
- [x] `README.md`

### `zsh/`

- [x] `ArchLabs_zshrc`
- [x] `zshrc`

More coming soon...hopefully.

## Installation guide

### Install using the wiki

First, clone the repository:

```sh
# Clone the repo
git clone https://github.com/michaelScopic/dotfiles

cd dotfiles
```

Then look at the [wiki](https://github.com/michaelScopic/dotfiles/wiki) for copying configs.

- Note: The wiki is really really out of date, sorry.

### Install using the provided script

Clone the repo:

```sh
git clone https://github.com/michaelScopic/dotfiles

cd dotfiles
```

Look at the possible agruments to use in the script by running:

- (cd into the dotfiles directory if you aren't already there)

```sh
./deploy.sh help
```

You can use these following arguments with this script: `all`, `plugins`, `backup`, or `overwrite`.

So if you want to run all of them, just do:

```sh
./deploy.sh all
```

If you don't want to run this script and only copy what you want, then just browse `config/` and/or `zsh/` and do what you want from there.

## Getting help

**Discord: `Michael_Scopic.zsh#0102`**

If you need help or something does not work as expected, please contact me on Discord.

I am almost _always_ online, and if I'm not online, I usually respond extremely quickly.

* NOTE: If you do contact me, tell me that you found me from GitHub and need help. I am extremely paranoid of who messages me, especially people I don't know.

## Contributing

I am still learning how to script in shell/bash, so my code will most likely not be the cleanest or most efficient or most functional.

Maybe you're smarter than me or know more about Linux. If you think you can clean up my code, address problems, or add new features, then go for it and make a new PR! But please read the guidelines below before you contribute.

### Contributing guidelines

ABSOLUTELY NO MALICIOUS CODE

Any form of malicious code is **not accepted under any curcumstances**, and any PR containing malicious code will just be rejected. I won't even argue with you if you have a malicious PR. Just fuck off.

**Comments:**

- Put comments breifly explaining what parts of your code does. Why? Because I want to know what you're doing so that (a) I can learn from it and (b) so that I can make sure it's not malicious.

- **If you do not put comments, I will not accept the PR.**

**Confusing/messy code:**

- Please please please don't make your code messy. It makes it much harder to read thru, and makes me not want to trust you.

- I understand if you aren't the most well versed in shell scripting, but ffs don't be a caveman when you submit code.

- If I get sensory overload from trying to read your code then I will most likely question both mine and your existance and then reject the PR.

**Test your code:**

- I've spent enough time testing my own code and I really don't want to test to see if your code works. So please test your own code and verify that it works.

## How to contribute

Read the GitHub docs on creating pull requests [here](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request?tool=codespaces). :)
