# custom commands for zsh

alias ls='ls -N --color=auto --group-directories-first'
alias run-help=man
alias which-command=whence
alias out='hyprctl dispatch "hl.dsp.exit()"'
alias rr='rm -r'
alias ee=nvim
alias sd=sudo
alias cdz='cd ..'
alias ccd='mkdir -p'
alias x='~/scripts/open.sh'


wifi.home() {
	nmcli device wifi rescan
	sleep 3 
	nmcli device wifi connect weeeee
}

wifi.phon() {
	nmcli device wifi rescan
	sleep 3 
	nmcli device wifi connect Helic
}


vi-cmd-mode() {
	local isEsc=1 REPLY
	while (( KEYS_QUEUED_COUNT || PENDING )); do
		isEsc=0
		zle read-command
	done
	((isEsc)) && zle .$WIDGET
}
zle -N vi-cmd-mode
KEYTIMEOUT=10



# for theseus mounting
alias addarchive='mount /home/helic/theseus'
alias remarchive='umount /home/helic/theseus'
