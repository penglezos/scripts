#!/bin/bash
#
# Script to setup Arch Linux personal configuration
#
# Usage:
#	./arch_setup.sh
#

# Install necessary packages
echo -e "Installing packages...\n"
sudo pacman -S --noconfirm \
    base-devel \
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
echo -e "Installing yay & prefered packages\n"
git clone https://aur.archlinux.org/yay.git && cd yay
makepkg -si
cd .. && rm -rf yay

sudo yay -S --noconfirm \
    google-chrome \
    chrome-gnome-shell \
    spotify \
    android-studio \
    android-sdk

# Enable bluetooth service
echo -e "Enabling bluetooth service...\n"
sudo systemctl start bluetooth.service
sudo systemctl enable bluetooth.service

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
