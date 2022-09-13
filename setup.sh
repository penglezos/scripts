#!/bin/bash

# Git profile configuration
git config --global user.name "penglezos"
git config --global user.email "panagiotisegl@gmail.com"
git config --global review.review.arrowos.net.username "penglezos"

# Git alias configuration
git config --global alias.cp 'cherry-pick'
git config --global alias.r 'revert'
git config --global alias.rc 'revert --no-commit'

# Install necessary packages
sudo pacman -S bluez bluez-utils blueman firefox git code htop neofetch telegram-desktop

# Enable bluetooth service
sudo systemctl start bluetooth.service
sudo systemctl enable bluetooth.service

# Install yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# AUR packages
sudo yay -S google-chrome chrome-gnome-shell

# Set swap
sudo swapoff -a
sudo dd if=/dev/zero of=/swapfile bs=1G count=16
sudo mkswap /swapfile
sudo swapon /swapfile

