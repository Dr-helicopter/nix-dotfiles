#!/bin/sh
# toggle-music.sh
current=$(niri msg workspaces | awk ' $1 == "*" { print $3 }' )
if [ "$current" = '"music"' ]; then
    niri msg action focus-workspace-previous
else
	echo "$current"
    niri msg action focus-workspace "music"
fi
