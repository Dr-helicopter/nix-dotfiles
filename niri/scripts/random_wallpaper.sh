#!/usr/bin/env bash

set -eu

WALLPAPER_DIR="${WALLPAPER_DIR:-$HOME/Pictures/wallpapers/active}"
MODE="${WALLPAPER_MODE:-fill}"   # fill, stretch, fit, center, tile

if [ ! -d "$WALLPAPER_DIR" ]; then
    echo "Wallpaper directory not found: $WALLPAPER_DIR" >&2
    exit 1
fi

IMAGE=$(find "$WALLPAPER_DIR" -type l \
    \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' \
	-o -iname '*.webp' -o -iname '*.bmp' \) | shuf -n 1)

if [ -z "$IMAGE" ]; then
	echo "No images found in $WALLPAPER_DIR" >&2
    exit 1
fi

pkill -x swaybg 2>/dev/null || true

sleep 0.1

/home/helic/.nix-profile/bin/swaybg -i "$IMAGE" -m "$MODE" &
disown

echo "Set wallpaper: $IMAGE"
