#!/usr/bin/env bash

# Save current working directory
cwd=$(pwd)

# Update
sudo pacman -Syu

# Install yay dependencies
sudo pacman -Sy --needed --noconfirm git base-devel

# Build yay from source
rm -rf $HOME/.local/share/yay
git clone "https://aur.archlinux.org/yay.git" $HOME/.local/share/yay >/dev/null
cd $HOME/.local/share/yay
makepkg -si --noconfirm

# Return to dotfiles directory
cd $cwd
