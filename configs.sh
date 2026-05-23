#!/usr/bin/env bash

# setup templater
cd templater
uv sync
cd ..

# AstroNvim
git clone --depth 1 https://github.com/AstroNvim/template $HOME/.config/nvim
rm -rf $HOME/.config/nvim/.git

# fuzzel
mkdir -p $HOME/.config/fuzzel/
./templater/.venv/bin/python ./templater/templater.py -t ./config/fuzzel/fuzzel.jinja.ini -e .env -o $HOME/.config/fuzzel/fuzzel.ini

# greetd + regreet configs
sudo cp ./config/greetd/config.toml /etc/greetd/config.toml
sudo cp ./config/greetd/hyprland.lua /etc/greetd/hyprland.lua
sudo ./templater/.venv/bin/python ./templater/templater.py -t ./config/greetd/regreet.jinja.toml -e .env -o /etc/greetd/regreet.toml

# hyprland
mkdir -p $HOME/.config/hypr/
./templater/.venv/bin/python ./templater/templater.py -t ./config/hypr/hyprland.jinja.conf -e .env -o $HOME/.config/hypr/hyprland.conf

# hyprpaper
cp ./config/hypr/hyprpaper.conf $HOME/.config/hypr/

# hyprsunset
cp ./config/hypr/hyprsunset.conf $HOME/.config/hypr/

# Kitty
mkdir -p $HOME/.config/kitty
./templater/.venv/bin/python ./templater/templater.py -t ./config/kitty/kitty.jinja.conf -e .env -o $HOME/.config/kitty/kitty.conf
cp ./config/kitty/current-theme.conf $HOME/.config/kitty/

# mako
mkdir -p $HOME/.config/mako
./templater/.venv/bin/python ./templater/templater.py -t ./config/mako/config.jinja -e .env -o $HOME/.config/mako/config

# NetworkManager auto-timezone script
sudo cp ./config/NetworkManager/09-timezone /etc/NetworkManager/dispatcher.d/

# oh-my-bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)" --unattended

# Power Menu
sudo cp ./power-menu/power-menu.jsx /usr/local/bin/
sudo ./templater/.venv/bin/python ./templater/templater.py -t ./power-menu/style.jinja.css -e .env -o /usr/local/bin/style.css

# System Updater
sudo cp ./system-updater/system-updater.sh /usr/local/bin/
sudo cp ./system-updater/system-updater.desktop /usr/share/applications/

# uwsm
mkdir -p $HOME/.config/uwsm
cp ./config/uwsm/env $HOME/.config/uwsm

# VSCodium
cp ./config/VSCodium/settings.json $HOME/.config/VSCodium/User/

# waybar
mkdir -p $HOME/.config/waybar/
cp ./config/waybar/config.jsonc $HOME/.config/waybar/
./templater/.venv/bin/python ./templater/templater.py -t ./config/waybar/style.jinja.css -e .env -o $HOME/.config/waybar/style.css

# wallpapers
sudo mkdir -p /usr/share/backgrounds/
sudo cp -R ./wallpapers/* /usr/share/backgrounds/
