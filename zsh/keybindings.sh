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
bindkey "^[t" edit-command-line
