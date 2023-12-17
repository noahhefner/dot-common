# dot-common
Noah Hefner system-agnostic dotfiles

# Usage

Assumptions:

- This repo has been cloned to `/home/$USER/dot-common`.

Use `stow` to create symbolic links to this directory. Run from `/home/$USER/dot-common`.

```
stow bash
stow kitty
stow mako
stow nvim
stow ranger
```

# Keybindings

## Sway

Another way to move windows is to hold `super` and click / drag with the mouse.

| Action                           | Keybinding             |
|----------------------------------|------------------------|
| Open terminal                    | `ctrl+enter`           |
| Open Yofi                        | `super+d`              |
| Swap to workspace 1/2/3...       | `super+1/2/3...`       |
| Move window to workspace 1/2/3...| `super+shift+1/2/3...` |
| Close active window              | `super+q`              |
| Make active window fullscreen    | `super+f`              |

## Kitty

| Action                        | Keybinding          |
|-------------------------------|---------------------|
| New Tab                       | `ctrl+shift+t`      |
| Close Tab                     | `ctrl+shift+q`      |
| Move to tab to the right      | `ctrl+shift+right`  |
| Move to tab to the left       | `ctrl+shift+left`   |
| New Kitty Window Horizontal   | `ctrl+shift+enter`  |
| Close Kitty Window            | `ctrl+shift+w`      |
| Move To Next Kitty Window     | `ctrl+shift+]`      |
| Move To Previous Kitty Window | `ctrl+shift+[`      |
| Open Ranger in new tab        | `ctrl+r`            |

## Neovim

**These keybindings should be executed in normal mode.**

### Window Management

| Action                          | Keybinding   |
|---------------------------------|--------------|
| Move to left window             | `ctrl+h`     |
| Move to right window            | `ctrl+l`     |
| Move to lower window            | `ctrl+j`     |
| Move to upper window            | `ctrl+k`     |
| Expand horizontal window size   | `ctrl+left`  |
| Reduce horizontal window size   | `ctrl+right` |
| Expand vertical window size     | `ctrl+down`  |
| Reduce vertical window size     | `ctrl+up`    |

### Nvim Tree

| Action           | Keybinding |
|------------------|------------|
| Toggle Nvim Tree | `space+f`  |

### Telescope

| Action               | Keybinding  |
|----------------------|-------------|
| Find file            | `space ff`  |
| Find in current file | `space fg`  |

### Barbar

| Action                  | Keybinding |
|-------------------------|------------|
| Move to previous buffer | `space ,`  |
| Move to next buffer     | `space .`  |
| Close current buffer    | `space c`  |

## Ranger

Ranger keybindings mimic Neovim for the most part. `h j k` and `l` can be used for navigation.

| Action                   | Keybinding |
|--------------------------|------------|
| Select one or more files | `space`    |
| Copy                     | `yy`       |
| Paste                    | `pp`       |
| Delete                   | `d`        |
| Undo                     | `u`        |

# Scripts

| Name | Action |
|-|-|
| `add_flathub_remote.sh` | adds flathub remote for flatpak
| `dl_grub_theme.sh` | downloads GRUB theme
| `install_cursors.sh` | downloads custom cursor pack
| `install_fonts.sh` | downloads Nerd Font
| `install_icons.sh` | downloads icon pack
| `install_system76_keyboard_configurator.sh` | installs Keyboard configurator for System76 Launch keyboard
| `make_dirs.sh` | create directories needed for configs
| `validate_repo_location.sh` | ensures this repository has been cloned to the correct location (user  shome)
