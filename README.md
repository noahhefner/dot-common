# Dotfiles

Configuration files for various distributions and desktop environments.

## Arch Linux

Assumes bare bones Arch Linux install.

### Gnome Desktop Envronment

1. Update the system, install `git`, and clone this repo.

```bash
#!/usr/bin/env bash

# Update
sudo pacman -Syu

# Install git
sudo pacman -S git

# Clone this repo
git clone "git@github.com:noahhefner/dotfiles.git" $HOME/dotfiles >/dev/null
```

2. Install `yay`.

```bash
#!/usr/bin/env bash

# Install yay dependencies
sudo pacman -Sy --needed --noconfirm git base-devel

# Build yay from source
rm -rf $HOME/.local/share/yay
git clone "https://aur.archlinux.org/yay.git" $HOME/.local/share/yay >/dev/null
cd $HOME/.local/share/yay
makepkg -si --noconfirm
```

3. Install Arch and AUR packages:

```bash
#!/usr/bin/env bash

# Install Arch packages
mapfile -t packages < <(grep -v '^#' "$HOME/dotfiles/arch/gnome/packages.arch.txt" | grep -v '^$')
sudo pacman -S --noconfirm --needed "${packages[@]}"

# Install AUR packages
mapfile -t packages < <(grep -v '^#' "$HOME/dotfiles/arch/gnome/packages.aur.txt" | grep -v '^$')
yay -S --noconfirm --needed "${packages[@]}"
```

4. Install configs.

```bash
#!/usr/bin/env bash

# AstroNvim
git clone --depth 1 https://github.com/AstroNvim/template $HOME/.config/nvim
rm -rf $HOME/.config/nvim/.git

# oh-my-bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)" --unattended

# oh-my-tmux
curl -fsSL "https://github.com/gpakosz/.tmux/raw/refs/heads/master/install.sh#$(date +%s)" | bash

# VSCodium
cp $HOME/dotfiles/config/VSCodium/settings.json $HOME/.config/VSCodium/User/
```

5. Final touches.

```bash
#!/usr/bin/env bash

# Change oh-my-bash theme to powerline
sed -i "s/^OSH_THEME=\".*\"/OSH_THEME=\"powerline\"/" "$HOME/.bashrc"

# Set (UnGoogled) Chromium as default browser
xdg-settings set default-web-browser chromium.desktop

# Enable avahi service
sudo systemctl enable avahi-daemon

# Enable bluetooth service
sudo systemctl enable bluetooth

# Enable docker service
sudo systemctl enable docker

# Enable cups service (printing)
sudo systemctl enable cups.service

# Add user to docker group
sudo usermod -aG docker $USER
```

6. Reboot the system.

7. Install flatpaks.

```bash
#!/usr/bin/env bash

# Install flatpaks
mapfile -t packages < <(grep -v '^#' "$HOME/dotfiles/arch/gnome/packages.flatpak.txt" | grep -v '^$')
flatpak install flathub --noninteractive "${packages[@]}"
```

### Hyprland Tiling Window Manager

## Debian

TBD

### Server

TBD