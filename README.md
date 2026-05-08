# .dotfiles

My dotfiles, managed by using stow

Using Hyprland, with Quickshell (Noctalia Shell)

## Required Packages

(arch only, for now)

Download using any AUR Helper programs

### Applications

```sh
yay -S --needed swaync noctalia-shell alacritty rofi zsh tmux neovim hyprshot hyprpaper hyprshutdown swaybg waypaper wayle mangohud
```

Use `awww` or `swaybg` for wallpapers. Then switch wallpapers using `waypaper` (except for `awww`)

### Fonts

```sh
yay -S --needed noto-fonts-cjk ttf-jetbrains-mono-nerd ttf-adwaitamono-nerd
```

## Install

(SSH)

```sh
git clone git@github.com:loldonut/dotfiles.git

```

then run the `install` script

```sh
./install
```
