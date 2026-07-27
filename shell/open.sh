#!/usr/bin/env bash


open_file() {
	file="$1"
	ext="${file##*.}"
	: ${IMG_VIWR:=zathura}

	[[ -f $LUA_SCRIPTS_PATH/celebi.lua ]] &&
		mpv_args="--script=$LUA_SCRIPTS_PATH/celebi.lua"

	[[ $TERM == 'linux' ]] &&
		IMG_VIWR=fbi
	

	case "${ext,,}" in
	cbz|pdf)
		zathura				"$file" ;;

	mp3|m4a|wav|flac)
		mpv	"$mpv_args"		"$file" ;;

	mp4|mkv|avi)
		mpv "$mpv_args"		"$file" ;;

	webp|jpeg|jpg|png)
		$IMG_VIWR			"$file" ;;

	txt|md|log|conf)
		nvim				"$file" ;;
		
	html|htm)
		qutebrowser			"$file" ;;

	zip)
		unzip				"$file" ;;

	rar)
		unrar x				"$file" ;;
		
	ipynb)
		jupyter-notebook	"$file" ;;

	docx|odt)
		libreoffice 		"$file" ;;

	*)
		echo "No default program defined for *.$ext" ;;
	esac
}


download() {
	LINK=$1
	if [[ $LINK == vlc* ]]; then

		t="${LINK#vlc}"
		LINK="http$t"
	fi
	aria2c -s 8 -x 8 "$LINK"
}


if [[ $# == 1 ]]; then
	open_file "$1"
elif [[ $1 == 'd' ]]; then 
	download $2
fi


