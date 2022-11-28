#!/bin/bash

#* This is a script to automate deploying these dotfiles onto the user's machine

#! This is a huge WIP, not usable right now.

# TODO: Literally everything


# --- Run initalizer ---
. init.sh
#---------------------------------------------#


# --- ZSH related scripts ---

# -- Run the zsh plugin installer --
## This script will try to handle the dependencies with 'dependencies.sh', so no need to run that here.
bash -c pluginInstall.sh

# -- Try to change user's shell to ZSH --

#---------------------------------------------#


# --- Deploy config files ---

# -- Backup user's current configs --
# TODO: Make a backup of user's configs first

# -- Overwrite user's configs with the dotfiles' configs
