{ theme, ... }:
{
	wayland.windowManager.hyprland.enable = true;
	wayland.windowManager.hyprland.sourceFirst = true;
	
	imports = [
		./animations.nix
		./rules.nix
	];

	wayland.windowManager.hyprland.extraLuaFiles = {
		imports.content = ''
		require("keybindings")
		'';
	};
	wayland.windowManager.hyprland.settings = {
		monitor = {
    		output   = "";
			mode     = "preferred";
			position = "auto";
			scale    = "1";
		};

		config = {
			general = {
				gaps_in = 5;
				gaps_out = 4;
        		border_size = 1;
				col = {
					active_border = "#"+theme.c6;
					inactive_border = "#"+theme.c4;
				};

				resize_on_border = false;
				allow_tearing = false;
				layout = "dwindle";
			};

			decoration = {
				active_opacity   = 1.0;
				inactive_opacity = 0.95;

				shadow.enabled = true;
				blur.enabled = false;
			};

			dwindle = {
				preserve_split = true;
			};
			master = {
				new_status = "master";
			};

			scrolling = {
				fullscreen_on_one_column = true;
			};

			input = {
				kb_layout  = "us, ir";
				kb_variant = "";
				kb_model   = "";
				kb_options = "grp:alt_shift_toggle,caps:hyper,compose:menu,shift:both_capslock";
				kb_rules   = "";

				repeat_rate = 60;
				repeat_delay = 400;
				follow_mouse = 1;

				sensitivity = 0;

				touchpad = {
					natural_scroll = false;
				};
			};

			misc = {
				force_default_wallpaper = -1;
				disable_hyprland_logo   = false;
			};
		};

		gesture = {
			fingers = 3;
			direction = "horizontal";
			action = "workspace";
		};
	};
}
