# .dotfiles

my dotfiles, managed by using stow

## Using
- Wayland Compositor: [Hyprland](https://github.com/hyprwm/Hyprland)
- Status Bar: [Wayle](https://github.com/wayle-rs/wayle)
- Color Generation Tool: [Matugen](https://github.com/InioX/matugen)
- Terminal Emulator: [Ghostty](https://github.com/ghostty-org/ghostty)
- Text Editor: [Neovim](https://github.com/neovim/neovim)

## Table of Contents

- [Clone Repository](#clone-repository)
- [Required Packages](#required-packages)
- [Install](#install)
- [Change Wallpaper](#change-wallpaper)
- [Whereis](#whereis-dotfiles)
- [Hyprland Configuration](#hyprland-configuration)

## Clone repository

##### SSH

```sh
git clone --recurse-submodules git@github.com:loldonut/dotfiles.git
```

##### HTTPS

```sh
git clone --recurse-submodules https://github.com/loldonut/dotfiles
```

## Required packages

**(arch only)** Download using any AUR Helper programs \
This config uses `hyprpaper` for wallpapers. Switch wallpapers using `waypaper` (except for `awww`)

```sh
yay -S --needed stow swaync alacritty rofi zsh tmux neovim hyprshot hyprpaper hyprshutdown swaybg waypaper wayle mangohud hyprpolkitagent ghostty grim slurp swappy dolphin brave-bin blueman wl-clipboard cliphist matugen
```

### Fonts

```sh
yay -S --needed noto-fonts-cjk ttf-jetbrains-mono-nerd ttf-adwaitamono-nerd
```

## Install

**Usage:**
```sh
./install [path_to_wallpaper]
```

- Will create a folder at `~/Pictures/Wallpapers` when it is not found. It will also generate a matugen color scheme when the script is run for the first time.
- Generates a file at `~/.local/state/dotfiles/.initialized` to know if the script has been run before.
- `path_to_wallpaper` will only be used when running the script for the first time. Otherwise it is ignored in favor of the `SUPER + SHIFT + W` bind in the Hyprland config

### Change wallpaper

Use the `SUPER + SHIFT + W` bind to change themes which will bring up a rofi menu showing images at `$HOME/Pictures/Wallpapers` \
This will run `matugen` automatically and change the color scheme.

## Whereis `dotfiles`

- **State:** `~/.local/state/dotfiles`
- **Share:** `~/.local/share/dotfiles`
  - Is used to store things like `colors.json` for neovim.

## Hyprland configuration

If you are having issues with `xdg-desktop-portal`, try running Hyprland with UWSM.

[**See README here**](https://github.com/loldonut/dotfiles/blob/main/hypr/README.md)
