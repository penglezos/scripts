#!/bin/bash
#
# Copyright (C) 2022-2024 Panagiotis Englezos <panagiotisegl@gmail.com>
#
# SPDX-License-Identifier: Apache-2.0
#
# Script to setup Arch Linux personal configuration
#

# Install necessary packages
echo -e "Installing packages...\n"
sudo pacman -S \
    android-tools \
    android-udev \
    base-devel \
    blueman \
    bluez \
    bluez-utils \
    code \
    cups \
    cups-pdf \
    filezilla \
    firefox \
    gedit \
    gimp \
    git \
    git-lfs \
    github-cli \
    gnome-browser-connector \
    hplip \
    htop \
    libreoffice-still \
    neofetch \
    nodejs \
    npm \
    ntfs-3g \
    powertop \
    telegram-desktop \
    virtualbox \
    wget \
    wireshark-qt

# Install yay
echo -e "Installing yay & prefered packages\n"
git clone https://aur.archlinux.org/yay.git && cd yay
makepkg -si
cd .. && rm -rf yay

yay -S \
    android-apktool \
    android-sdk \
    android-studio \
    anydesk-bin \
    aosp-devel \
    gitkraken \
    google-chrome \
    lineageos-devel \
    local-by-flywheel-bin \
    spotify \
    stremio

# Install extra GNOME packages
if [ "$XDG_CURRENT_DESKTOP" = "GNOME" ]; then
    echo -e "Installing packages for GNOME...\n"
    sudo pacman -S \
        gnome-tweaks
fi

# If device is a laptop install necessary packages
if [ -d "/proc/acpi/button/lid" ]; then
    echo -e "Installing packages for laptop...\n"
    sudo pacman -S \
        tlp
fi

# Enable bluetooth service
echo -e "Enabling bluetooth service...\n"
sudo systemctl start bluetooth.service
sudo systemctl enable bluetooth.service

# Enable printer service
echo -e "Enabling printer service...\n"
sudo systemctl enable cups.service
sudo systemctl start cups.service

# Git profile configuration
echo -e "Configuring git profile...\n"
git config --global user.name "penglezos"
git config --global user.email "panagiotisegl@gmail.com"
git config --global review.review.lineageos.org.username "englezos"

# Git alias configuration
echo -e "Configuring git alias shortcuts...\n"
git config --global alias.cp 'cherry-pick'
git config --global alias.r 'revert'
git config --global alias.rc 'revert --no-commit'
git config --global core.editor "nano"
