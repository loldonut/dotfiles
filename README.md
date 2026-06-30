<img width="5120" height="1440" alt="dotfiles_preview" src="https://github.com/user-attachments/assets/0a9b352b-180d-4e29-8385-b4b24e886c9b" />

# .dotfiles

my dotfiles, managed by using stow

## Using
- **Wayland Compositor:** [Hyprland](https://github.com/hyprwm/Hyprland)
- **Status Bar:** [Wayle](https://github.com/wayle-rs/wayle)
- **Color Generation Tool:** [Matugen](https://github.com/InioX/matugen)
- **Terminal Emulator:** Fish + [Ghostty](https://github.com/ghostty-org/ghostty) **/** zsh + [Kitty](https://github.com/kovidgoyal/kitty) for launching programs that requires rendering.
- **Text Editor:** [Neovim](https://github.com/neovim/neovim)

### Thanks to

- GTK Template: [end-4/dots-hyprland](https://github.com/end-4/dots-hyprland)
- [Tmux Sessionizer](https://github.com/ThePrimeagen/tmux-sessionizer) by ThePrimeagen

## Table of Contents

- [Clone Repository](#clone-repository)
- [Install](#install)
  - [Required Packages](#required-packages)
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

## Install

### Required packages

**(arch only)** Download using any AUR Helper programs \
This config uses `hyprpaper` for wallpapers. Switch wallpapers using the bind `SUPER + SHIFT + W`

```sh
yay -S --needed git stow
```

<details>

<summary>Fonts</summary>

- `noto-fonts-cjk`
- `ttf-jetbrains-mono-nerd`
- `ttf-adwaitamono-nerd`

### Install manually

```sh
yay -S --needed noto-fonts-cjk ttf-jetbrains-mono-nerd ttf-adwaitamono-nerd
```

</details>

**Usage:**
```sh
Usage: ./setup [COMMAND|PATH_TO_WALLPAPER] [OPTIONS]

COMMANDS

      help                  displays this help message
      reset                 resets the state of dotfiles setup

OPTIONS

      -m, --skip-matugen    skips matugen color generation step
      -h, --help            displays this help message
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

If you are having issues with `xdg-desktop-portal`, try running [Hyprland with UWSM.](https://wiki.hypr.land/Useful-Utilities/Systemd-start)

[**See README here**](https://github.com/loldonut/dotfiles/blob/main/hypr/README.md)

