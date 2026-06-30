#!/usr/bin/env bash

log() {
    printf "\e[1;32m[dotfiles]\e[0m %s\n" "$*";
}

log_die() {
    printf "\e[1;32m[dotfiles]\e[0m %s\n" "$*" >&2;
    exit 1
}

log_warn() {
    printf "\e[1;33m[dotfiles]\e[0m %s\n" "$*"
}
