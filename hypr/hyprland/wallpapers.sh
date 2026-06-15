#!/usr/bin/env bash

WALLPAPER_FOLDER="${1}"

declare -a basenames
declare -a fullpaths

while IFS= read -r f; do
  basenames+=("$(basename "$f")")
  fullpaths+=("$f")
done < <(find "$WALLPAPER_FOLDER" -maxdepth 1 -type f)

# Show only basenames in rofi, get the selected index
idx=$(printf '%s\n' "${basenames[@]}" | rofi -dmenu -p "Select file:" -format i)

[ -z "$idx" ] && exit 0

# Use index to retrieve full path
SELECTED="${fullpaths[$idx]}"

hyprctl notify 1 2000 "#ffffff" "Image selected: ${SELECTED}"
matugen image $SELECTED --verbose --source-color-index 0
