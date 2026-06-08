#!/usr/bin/env bash

# Install custom scripts
sudo cp ./scripts/* /usr/local/bin/

# Create directory for screenshots
mkdir -p $HOME/Pictures/Screenshots

# Copy files for web apps
sudo mkdir -p /usr/share/icons/dotfiles
sudo cp ./web-apps/desktop/* /usr/share/applications/
sudo cp ./web-apps/icons/* /usr/share/icons/dotfiles/

# Change oh-my-bash theme to powerline
sed -i "s/^OSH_THEME=\".*\"/OSH_THEME=\"powerline\"/" "$HOME/.bashrc"

# Set (UnGoogled) Chromium as default browser
xdg-settings set default-web-browser chromium.desktop

# Enable avahi service
sudo systemctl enable avahi-daemon

# Enable greetd service
sudo systemctl enable greetd

# Enable bluetooth service
sudo systemctl enable bluetooth

# Enable docker service
sudo systemctl enable docker

# Enable cups service (printing)
sudo systemctl enable cups.service

# Add user to docker group
sudo usermod -aG docker $USER

# Reboot instructions
echo "Setup is complete. Please reboot."
