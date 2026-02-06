#!/bin/bash

set -e

log_update() {
    echo -e "\033[0;31m[update $1]\033[0m"
}

update_with_sudo() {
    if command -v apk &> /dev/null; then
        log_update apk
        apk update && apk upgrade
    fi

    if command -v apt &> /dev/null; then
        log_update apt
        apt update && apt upgrade -y && apt autoremove -y
    fi

    if command -v dnf &> /dev/null; then
        log_update dnf
        dnf upgrade -y
    fi

    if command -v pacman &> /dev/null; then
        log_update pacman
        pacman -Syu --noconfirm
    fi

    if command -v snap &> /dev/null; then
        log_update snap
        snap refresh
    fi

    if command -v zypper &> /dev/null; then
        log_update zypper
        zypper update -y
    fi
}

sudo bash -c "$(declare -f log_update); $(declare -f update_with_sudo); update_with_sudo"

if command -v brew &> /dev/null; then
    log_update brew
    brew update && brew upgrade
fi

if command -v flatpak &> /dev/null; then
    log_update flatpak
    flatpak update -y
fi

if command -v yay &> /dev/null; then
    log_update yay
    yay -Syu --noconfirm
fi

echo -e "\n\033[0;31m[all updates complete]\033[0m"

if [ -f /var/run/reboot-required ]; then
    echo -e "\n\033[1;33mA system reboot is required.\033[0m"
fi
