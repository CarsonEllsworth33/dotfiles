#!/bin/bash
SCREEN=`~/.config/hypr/scripts/get-current-monitor-name`
echo "$SCREEN"
case "$1" in
	"region-copy")
		grim -g "$(slurp)" - | wl-copy
		;;
	"screen-copy")
		grim -o "$SCREEN" - | wl-copy
		;;
	"region")
		grim -g "$(slurp)"
		;;
	"screen")
		grim -o "$SCREEN"
		;;
	"all")
		;;
	*)
		;;
esac
