#!/bin/bash
#
# Script to setup Arch Linux personal configuration
#
# Usage:
#	./arch_setup.sh
#

# Install necessary packages
sudo pacman -S \
    bluez \
    bluez-utils \
    blueman \
    firefox \
    git \
    code \
    htop \
    neofetch \
    telegram-desktop

# Install yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# AUR packages
sudo yay -S \
    google-chrome \
    chrome-gnome-shell \
    spotify \
    android-studio \
    android-sdk

# Enable bluetooth service
sudo systemctl start bluetooth.service
sudo systemctl enable bluetooth.service

# Git profile configuration
git config --global user.name "penglezos"
git config --global user.email "panagiotisegl@gmail.com"
git config --global review.review.lineageos.org.username "englezos"

# Git alias configuration
git config --global alias.cp 'cherry-pick'
git config --global alias.r 'revert'
git config --global alias.rc 'revert --no-commit'

