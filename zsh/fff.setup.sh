# setup for instant fff

fff() {
	command fff "$@"
	cd "$(cat "${XDG_CACHE_HOME:=${HOME}/.cache}/fff/.fff_d")"
}

fff-widget() {
	zle -I		# flush ZLE input, get the hell out of the way
    fff </dev/tty >/dev/tty
}

zle -N fff-widget
