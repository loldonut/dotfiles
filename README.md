# .dotfiles

My dotfiles, managed by using stow \
Using Hyprland, with [Wayle](https://github.com/wayle-rs/wayle) as status bar

## Clone Repository

##### SSH

```sh
git clone --recurse-submodules git@github.com:loldonut/dotfiles.git
```

##### HTTPS

```sh
git clone --recurse-submodules https://github.com/loldonut/dotfiles
```

## Required Packages

**(arch only)** Download using any AUR Helper programs \
You can use `awww`, `swaybg`, and `hyprpaper` for wallpapers. Then switch wallpapers using `waypaper` (except for `awww`)

```sh
yay -S --needed stow swaync alacritty rofi zsh tmux neovim hyprshot hyprpaper hyprshutdown swaybg waypaper wayle mangohud hyprpolkitagent ghostty grim slurp swappy
```

### Fonts

```sh
yay -S --needed noto-fonts-cjk ttf-jetbrains-mono-nerd ttf-adwaitamono-nerd
```

## Install

**Run script to install**
```sh
./install
```
