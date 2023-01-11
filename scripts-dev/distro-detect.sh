#!/usr/bin/env bash

# --- Detect Distro ---
function detect_distro() {
    if [ ! -f "/etc/os-release" ]; then
        echo "Can't find '/etc/os-release'. Unable to continue."
    fi

    . /etc/os-release

    echo "Name: ${NAME}"
    echo "ID: ${ID}"
    echo "ID like: ${ID_LIKE}"
    echo "Pretty name: ${PRETTY_NAME}"
    echo ""

    if [ ${ID} == "ubuntu" ] || [ ${ID} == "debian" ] || [ ${ID_LIKE} == '"ubuntu debian"' ]; then
        echo "Found Ubuntu/Debian."
        distro="debian"

    elif [ ${ID} == "Arch Linux" ] || [ ${ID_LIKE} == '"arch"' ]; then
        echo "Found Arch Linux."
        distro="arch"

    elif [ ${ID} == "fedora" ]; then
        echo "Found Fedora Linux."
        distro="rhel"

    elif [ ${NAME} == "openSUSE Tumbleweed" ]; then
        echo "Found openSUSE Tumbleweed"
        distro="opensuse"
    
    else 
        echo -e "Couldn't detect your distro :("
    fi
}

detect_distro

