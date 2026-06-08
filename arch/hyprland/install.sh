#!/usr/bin/env bash

# Install Arch packages
mapfile -t packages < <(grep -v '^#' "./packages.arch.txt" | grep -v '^$')
sudo pacman -S --noconfirm --needed "${packages[@]}"

# Install AUR packages
mapfile -t packages < <(grep -v '^#' "./packages.aur.txt" | grep -v '^$')
yay -S --noconfirm --needed "${packages[@]}"