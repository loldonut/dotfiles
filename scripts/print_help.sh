#!/usr/bin/env bash

bold_fmt() {
    echo -e "\e[1;97m$*\e[0m"
}

print_help() {
    echo "Usage: setup [COMMAND|PATH_TO_WALLPAPER] [OPTIONS]"
    echo
    bold_fmt "COMMANDS"
    echo
    echo "      $(bold_fmt "help")                  displays this help message"
    echo "      $(bold_fmt "reset")                 resets the state of dotfiles setup"
    echo
    bold_fmt "OPTIONS"
    echo
    echo "      $(bold_fmt "-m, --skip-matugen")    skips matugen color generation step"
    echo "      $(bold_fmt "-h, --help")            displays this help message"

    exit 0
}
