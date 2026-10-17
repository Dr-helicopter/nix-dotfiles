{ pkgs, theme, ... }: {
	wayland.windowManager.niri.enable = true;

	home.packages = with pkgs;[
		
	    quickshell
		swaybg
		niri
	];
	home.file.".config/niri/config.kdl".text =
		builtins.replaceStrings
			[
			  "\${theme.c14}"
			  "\${theme.c4}"
			  "\${theme.c1}"
			]
			[
			  theme.c14
			  theme.c4
			  theme.c1
			]
			(builtins.readFile ./config.kdl);

	home.file = {
		"scripts/music-workspace-toggle.sh" = {
			source = ./scripts/music-workspace-toggle.sh;
			executable = true;
		};
		"scripts/setup_wallpaper.sh" = {
			source = ./scripts/setup_wallpaper.sh;
			executable = true;
		};
		"scripts/random_wallpaper.sh" = {
			source = ./scripts/random_wallpaper.sh;
			executable = true;
		};
		"scripts/quickshell-setup.sh" = {
			source = ./scripts/quickshell-setup.sh;
			executable = true;
		};

		".config/quickshell.shell.qml" = {
			source = ./quickshell/shell.qml;
		};
	};
}
