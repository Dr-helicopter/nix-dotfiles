#!/bin/sh

dir=~/.config/niri/daemons

for i in "$dir"/*; do 
	[[ -x "$i" ]] && ($i &)
done
