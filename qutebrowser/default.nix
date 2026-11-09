{ pkgs, ... }: {
  wayland.windowManager.niri.enable = true;

  home.packages = with pkgs; [
	yt-dlp
    qutebrowser

	(pkgs.writeShellApplication {
      name = "yt-mpv.sh";
      runtimeInputs = [
        pkgs.yt-dlp
      ];

      text = ''		 
		if [ -z "$1" ]; then
			echo "Usage: $0 <youtube-url> [proxy]"
			exit 1
		fi

		url="$1"
		proxy="$2"

		if [ -n "$proxy" ]; then
			cd /tmp || exit 1

			# -f picks the best single-file format up to 720p (can be piped)
			mpv <(yt-dlp --cookies-from-browser firefox --proxy "$proxy" \
				-f "b[height<=720]" -o - "$url" 2>/tmp/yt-mpv.log)
		else
			mpv --ytdl-format="bv*[height<=720]+ba/b[height<=720]" \
				--ytdl-raw-options="cookies-from-browser=firefox" "$url"
		fi
      '';
    })
  ];

  home.file.".config/qutebrowser/config.py".source = ./config.py;
  xdg.mimeApps. defaultApplications = {
    "x-scheme-handler/http" = [ "org.qutebrowser.qutebrowser.desktop" ];
    "x-scheme-handler/https" = [ "org.qutebrowser.qutebrowser.desktop" ];
  };
}
