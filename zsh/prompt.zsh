autoload -Uz vcs_info
precmd() { vcs_info }

setopt prompt_subst

short_pwd() {
	local p="${(D)PWD}"
	local parts=("${(@s:/:)p}")
	local out=""
	local last=${parts[-1]}

	for dir in ${parts[1,-2]}; do
		[[ -n $dir ]] && out+="${dir[1]}/"
	done

	out+="$last"
	print "$out"
}

zstyle ':vcs_info:git:*' formats '(%b)'
zstyle ':vcs_info:*' enable git

PS1='%F{green}%n%F{cyan}@%B%F{green}%m%f %F{81}$(short_pwd)%f %F{magenta}${vcs_info_msg_0_}%B%F{black}> %f'

