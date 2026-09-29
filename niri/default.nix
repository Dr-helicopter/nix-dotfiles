{ theme, ... }: {
	wayland.windowManager.niri.enable = true;

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

	home.file."scripts/music-workspace-toggle.sh" = {
		source = ./scripts/music-workspace-toggle.sh;
		executable = true;
	};
}
