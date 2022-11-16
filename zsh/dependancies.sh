#!/bin/bash

# * Script to install dependancies according to user's distro/package manager
# * REQUIRED BY: pluginInstall.sh

# TODO: literally everything


# Find user's distro and store it as a variable
#echo "$(lsb_release -sd | cut -f 1-)"
distro1="$(cat /etc/os-release | grep ^NAME | awk -F'"' '{print $2 }')"
distro2="$(cat /etc/os-release | grep ID_LIKE | awk -F= '{ print $2 }')"
echo "NAME: $distro1  ID_LIKE:$distro2"

if [ "$distro2" == "" ]; then
    # If $distro2 has nothing, then prefer $distro1
    distro=$distro1
    echo $distro
else
    # If $distro2 has text, then prefer $distro2
    distro=$distro2
    echo $distro
fi

