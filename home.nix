{ config, pkgs, nixgl, lib, machine, theme, ... }:

let
	CustomWmenu = pkgs.wmenu.overrideAttrs (oldAttrs: {
			src = pkgs.fetchFromGitHub {
			owner = "Dr-helicopter";
			repo = "wmenu";
			rev = "main";
			hash = "sha256-bUr4AyxCLygOcWe37UALmEsnI1ADsbjRiejb5ZqRekE=";
		};
	});
	foot-font-size = 
		if machine == "nixman" then "15"
		else "10";
in
{
	home.username = "helic";
	home.homeDirectory = "/home/helic";


	# This value determines the Home Manager release that your configuration is
	# compatible with. This helps avoid breakage when a new Home Manager release
	# introduces backwards incompatible changes.
	#
	# You should not change this value, even if you update Home Manager. If you do
	# want to update the value, then make sure to first check the Home Manager
	# release notes.
	home.stateVersion = "26.05"; # Please read the comment before changing.

	home.packages = with pkgs;[
		btop
		moreutils
		alsa-utils
		ffmpeg
		hyprland
		hyprcursor
		hyprpaper
		swappy
		grim
		jq
		rose-pine-hyprcursor
		CustomWmenu
		nerd-fonts.mononoki
		ayugram-desktop
		godot
		fastfetch
		neovim-remote
		newsboat
		obs-studio
		gimp
		libreoffice
		zip unzip
	];
 
	# services.hyprpaper.enable = true;
	systemd.user.services.hyprpaper_custom = {
		Unit = {
			Description = "custom hyprpaper";
			After = [ "graphical-session.target" ];
		};

		Install = {
			WantedBy = [ "graphical-session.target" ];
		};
		Service = {
			ExecStart = "${nixgl.packages.${pkgs.stdenv.hostPlatform.system}.default}/bin/nixGL hyprpaper";

			# ExecStart = "${pkgs.hyprpaper}/bin/hyprpaper";
		};
	};


	imports = [
		./hyprland
	];

	home.file = {
		".config/ls_color.sh".source = ./shell/ls_color.sh;
		".config/ffff/config.sh".source = ./shell/ffff_config.sh;
		".config/color_scheme".text = ''
			BG_PRIME=${theme.bg}
			TEXT_PRIME=${theme.fg}
			
			COLOR0=${theme.c0}
			COLOR1=${theme.c1}
			COLOR2=${theme.c2}
			COLOR3=${theme.c3}
			COLOR4=${theme.c4}
			COLOR5=${theme.c5}
			COLOR6=${theme.c6}
			COLOR7=${theme.c7}
		'';
		"scripts/open.sh".source = ./shell/open.sh;

		"programs/.generic".text = ''
			#!/usr/bin/env bash

			exec $(basename "$0")
		'';
		
		".lesskey".text = ''
			# command
			w back-line
			s forw-line
		'';
	};
	home.file."programs/.generic".executable = true;

	home.file."scripts/home-switch.sh" = {
text = ''
#!/usr/bin/env bash

home-manager switch --impure --flake "$HOME"/.config/home-manager#"$(uname -n)"
'';
		executable = true;
	};

	# Home Manager can also manage your environment variables through
	# 'home.sessionVariables'. These will be explicitly sourced when using a
	# shell provided by Home Manager. If you don't want to manage your shell
	# through Home Manager then you have to manually source 'hm-session-vars.sh'
	# located at either
	#
	#	~/.nix-profile/etc/profile.d/hm-session-vars.sh
	#
	# or
	#
	#	~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
	#
	# or
	#
	#	/etc/profiles/per-user/helic/etc/profile.d/hm-session-vars.sh
	#
	home.sessionVariables = {
		EDITOR = "nvim";
		SUDO_EDITOR = "nvim";
		MANPAGER = "nvim +Man!";
		SCRIPTS_PATH = "$HOME/scripts";
		LUA_SCRIPTS_PATH = "$HOME/scripts/lua";
	};

	home.sessionPath = [ 
		"$HOME/scripts"
	];
	# Let Home Manager install and manage itself.
	programs.home-manager.enable = true;

	programs.zsh = {
		enable = true;
		autosuggestion.enable = true;
		shellAliases = {
			x = "~/scripts/open.sh";
			rsca = "rsync -carv --progress";
		};

		setOptions = [
			"EXTENDED_GLOB"
		];

		initContent = ''
			# If not running interactively, don't do anything
			[[ $- != *i* ]] && return

			export HISTFILE=~/.shell_history
			export HISTSIZE=10000
			export SAVEHIST=10000
			export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE=$zsh_suggestion_col",bg=0"

			source ~/.config/ls_color.sh
			source ~/.config/zsh/prompt.zsh
			source ~/.config/zsh/fff.setup.sh
			source ~/.config/zsh/commands.sh
			source ~/.config/zsh/keybindings.sh
			[[ -f "$HOME/.zshrc_local" ]] && source "$HOME/.zshrc_local"
		'';
	};
	home.file.".config/zsh".source = ./zsh;

	programs.mpv = {
		enable=true;
		config = {
			hwdec = "auto-safe";
			target-colorspace-hint = "no";

		};

		bindings = {
			"w" = "add volume  2";
			"s" = "add volume -2";
			"d" = "seek  1";
			"a" = "seek -1";

			"D" = "seek  60";
			"A" = "seek -60";

			"c" = "cycle audio";
		};
	};


	programs.zathura = {
		enable = true;

		mappings = {
			q = "quit";

			D = "toggle_page_mode";

			w = "scroll up";
			s = "scroll down";
			a = "scroll left";
			d = "scroll right";

			W = "navigate previous";
			S = "navigate next";

			"<A-w>" = "zoom in";
			"<A-s>" = "zoom out";

			"w fullscreen" = "scroll up";
			"s fullscreen" = "scroll down";
			"a fullscreen" = "scroll left";
			"d fullscreen" = "scroll right";

			"W fullscreen" = "navigate previous";
			"S fullscreen" = "navigate next";

			"<A-w> fullscreen" = "zoom in";
			"<A-s> fullscreen" = "zoom out";
		};
	};

	programs.foot = {
		enable = true;
		settings = {
			main = 
			let
				font-family = "Mononoki Nerd Font Mono";
			in
			{
				font = "${font-family}:style=Regular:size=${foot-font-size}";
				font-bold = "${font-family}:style=Bold:size=${foot-font-size}";
				font-italic = "${font-family}:style=Italic:size=${foot-font-size}";
				font-bold-italic = "${font-family}:style=BoldItalic:size=${foot-font-size}";
				dpi-aware = true;
			};
			cursor = {
				style = "block";
			};
			colors-dark = {
				alpha = 1;
				alpha-mode = "default";
				background = theme.bg;
				foreground = theme.fg;

				regular0 = theme.c0;
				regular1 = theme.c1;
				regular2 = theme.c2;
				regular3 = theme.c3;
				regular4 = theme.c4;
				regular5 = theme.c5;
				regular6 = theme.c6;
				regular7 = theme.c7;

				bright0 = theme.c8;
				bright1 = theme.c9;
				bright2 = theme.c10;
				bright3 = theme.c11;
				bright4 = theme.c12;
				bright5 = theme.c13;
				bright6 = theme.c14;
				bright7 = theme.c15;
			};
		};
	};
}
