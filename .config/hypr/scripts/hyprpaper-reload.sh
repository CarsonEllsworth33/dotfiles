#!/usr/bin/env bash

if [ "$1" = "dark" ]; then
	WALLPAPER_DIR="$HOME/.config/hypr/wallpapers/dark"
else
	WALLPAPER_DIR="$HOME/.config/hypr/wallpapers/light"
fi
CURRENT_WALL=$(hyprctl hyprpaper listloaded)

# Get a random wallpaper that is not the current one
WALLPAPER=$(find "$WALLPAPER_DIR" -type f ! -name "$(basename "$CURRENT_WALL")" | shuf -n 1)

# Apply the selected wallpaper
hyprctl hyprpaper reload ,"$WALLPAPER"
