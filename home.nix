{ config, pkgs, nixgl, lib, machine, ... }:

let
	CustomWmenu = pkgs.wmenu.overrideAttrs (oldAttrs: {
			src = pkgs.fetchFromGitHub {
			owner = "Dr-helicopter";
			repo = "wmenu";
			rev = "main";
			hash = "sha256-X0Q3IdIe5oLzF5TXbhV8JZmrLEIl5qGiNBi0kaAuVVY=";
		};
	});
	color-palate= {
		bg= "000000";
		fg= "c5efff";

		c0 = "141414";
		c1 = "f62b5a";
		c2 = "17a411";
		c3 = "e3a401";
		c4 = "144c84";
		c5 = "df1fdf";
		c6 = "13c299";
		c7 = "e6e6e6";

		c8 = "616161";
		c9 = "ff4d51";
		c10= "35d450";
		c11= "e9e836";
		c12= "7dc5ff";
		c13= "feabf2";
		c14= "24dfc4";
		c15= "ffffff";
	};
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

	# The home.packages option allows you to install Nix packages into your
	# environment.

	home.packages = with pkgs;[
		alsa-utils
		ffmpeg
		hyprland
		hyprcursor
		jq
		rose-pine-hyprcursor
		CustomWmenu
		nerd-fonts.mononoki
		ayugram-desktop
		godot
		fastfetch
	];

	home.file = {
		".config/ls_color.sh".source = ./shell/ls_color.sh;
		".config/ffff/config.sh".source = ./shell/ffff_config.sh;
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
		SCRIPTS_PATH = "~/scripts";
		LUA_SCRIPTS_PATH = "~/scripts/lua";
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
		};

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
				background = color-palate.bg;
				foreground = color-palate.fg;

				regular0 = color-palate.c0;
				regular1 = color-palate.c1;
				regular2 = color-palate.c2;
				regular3 = color-palate.c3;
				regular4 = color-palate.c4;
				regular5 = color-palate.c5;
				regular6 = color-palate.c6;
				regular7 = color-palate.c7;

				bright0 = color-palate.c8;
				bright1 = color-palate.c9;
				bright2 = color-palate.c10;
				bright3 = color-palate.c11;
				bright4 = color-palate.c12;
				bright5 = color-palate.c13;
				bright6 = color-palate.c14;
				bright7 = color-palate.c15;
			};
		};
	};
}
