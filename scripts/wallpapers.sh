#!/usr/bin/env bash

wallpapers_selector() {
  WALLPAPER_FOLDER="${1}"

  declare -a basenames
  declare -a fullpaths

  while IFS= read -r -d '' f; do
    basenames+=("$(basename -- "$f")")
    fullpaths+=("$f")
  done < <(find "$WALLPAPER_FOLDER" -maxdepth 1 -type f -print0)

  # Build rofi entries: "display_name\0icon\x1fpath_to_image\n"
  # Spaces replaced with NBSP (U+00A0) so rofi doesn't word-split when searching
  idx=$(for i in "${!basenames[@]}"; do
  name="${basenames[$i]// / }"
  path="${fullpaths[$i]}"
  printf '%s\x00icon\x1f%s\n' "$name" "$path"
  done | PREVIEW=true rofi -no-config -theme fullscreen-preview.rasi -dmenu -i -p "Select file:" -format i -show-icons)

  [ -z "$idx" ] && exit 0

  SELECTED="${fullpaths[$idx]}"

  hyprctl notify 1 2000 "#ffffff" "Image selected: ${SELECTED}"
  matugen image "$SELECTED" --verbose --source-color-index 0
}

