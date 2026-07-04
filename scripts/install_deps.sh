#!/usr/bin/env bash

DEPS=(
    stow
    zsh
    tmux
    neovim
    alacritty
    rofi
    grim
    slurp
    swappy
    mangohud
    blueman
    wl-clipboard
    cliphist
    fish
    fzf
    qt5-wayland
    qt6-wayland
    quickshell
    zoxide
    starship
    xdg-desktop-portal
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    network-manager-applet
    dolphin
    kitty
    swaync
    hyprshot
    hyprpaper
    hyprshutdown
    waypaper
    hyprpolkitagent
    ghostty
    brave-bin
    matugen
)

FONT_DEPS=(
    noto-fonts-cjk
    ttf-jetbrains-mono-nerd
    ttf-adwaitamono-nerd
)

install_deps() {
    if [[ -f "${STAMP_FILE}" ]]; then
        log_warn "dotfiles has already been initialized."
        log_die "exiting.."
    fi

    # Install yay if missing
    if ! command -v yay &>/dev/null; then
        log "yay not found. Installing yay from AUR..."

        local tmp_dir
        tmp_dir="$(mktemp -d)"

        git clone --depth=1 https://aur.archlinux.org/yay-bin.git "$tmp_dir"
        (cd "$tmp_dir" && makepkg -si --noconfirm)
        rm -rf "$tmp_dir"
    fi

    log "Installing dependencies..."
    yay -S --needed --noconfirm "${DEPS[@]}"

    log "Installed required dependencies."
    printf "\e[1;34m[dotfiles]\e[0m Install fonts? (noto-fonts-cjk ttf-jetbrains-mono-nerd ttf-adwaitamono-nerd) [Y/n] "
    read -r reply
    if [[ -z "${reply}" || "${reply,,}" == "y" ]]; then
        log "Installing fonts..."
        yay -S --needed --noconfirm "${FONT_DEPS[@]}"
        log "Fonts installed."
    else
        log "Skipping font installation."
    fi
}
