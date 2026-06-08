#!/usr/bin/env bash

# The machine needs to be rebooted after installing the Flatpak package before
# Flatpaks can be installed.

# Install flatpaks
mapfile -t packages < <(grep -v '^#' "./packages.flatpak.txt" | grep -v '^$')
flatpak install flathub --noninteractive "${packages[@]}"