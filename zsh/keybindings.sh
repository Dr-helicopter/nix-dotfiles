# keybinding settings
autoload -Uz edit-command-line
zle -N edit-command-line

_instant_ls() {
	printf '\n'
	ls
	zle reset-prompt
}
zle -N _instant_ls

_full_clear() {
	printf '\033c'
	zle reset-prompt
}
zle -N _full_clear

_mm_pause() {
	musicman-daemon pause-play 1> /dev/null
	[[ $? -eq 2 ]] && 
		echo FUCK
}
zle -N _mm_pause
bindkey "^[2" _mm_pause

_mm_vdown() {
	musicman-daemon vdown 1> /dev/null
	[[ $? -eq 2 ]] && 
		echo FUCK
}

zle -N _mm_vdown
bindkey "^[2" _mm_vdown

_mm_vup() {
	musicman-daemon vup 1> /dev/null
	[[ $? -eq 2 ]] && 
		echo FUCK
}
zle -N _mm_vup


_open_mm() {
	zle -I		# flush ZLE input, get the hell out of the way
    musicman </dev/tty >/dev/tty
}
zle -N _open_mm


# a very inefficent way of doing things :
delete-argument() {
	local before="${BUFFER[1,$CURSOR]}"
	local after="${BUFFER[$CURSOR+1,-1]}"

	# Find the beginning of the current component.
	# Components are separated by whitespace or /
	local left="${before##*[[:space:]/]}"
	local start=$(( CURSOR - ${#left} + 1 ))

	# If we're immediately after /, include the /
	if (( start > 1 )) && [[ "${BUFFER[start-1]}" == "/" ]]; then
	(( start-- ))
	fi

	# Find the end of the current component
	local right="${after%%[[:space:]/]*}"
	local end=$(( CURSOR + ${#right} ))

	# Remove trailing whitespace as well
	while (( end < ${#BUFFER} )) && [[ "${BUFFER[end+1]}" == " " || "${BUFFER[end+1]}" == $'\t' ]]; do
	(( end++ ))
	done

	BUFFER="${BUFFER[1,start-1]}${BUFFER[end+1,-1]}"
	while [[ "$BUFFER" ==  *' ' |  "$BUFFER" ==  *"\n"]]; do
		BUFFER="${BUFFER:0:-1}"
	done

	CURSOR=$(( start - 1 ))
}
zle -N delete-argument



bindkey "^[1" _mm_vdown
bindkey "^[2" _mm_pause
bindkey "^[3" _mm_vup
bindkey "^[g" _open_mm

bindkey "^[a" backward-char
bindkey "^[d" forward-char
bindkey "^[e" accept-line
bindkey "^[f" fff-widget
bindkey "^[r" _instant_ls
bindkey "^[c" _full_clear
bindkey "^[s" down-line-or-history
bindkey "^[w" up-line-or-history
bindkey "^[x" vi-backward-delete-char
bindkey "^[X" delete-argument
bindkey "^[t" edit-command-line
