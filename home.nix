{ config, pkgs, nixgl, lib, ... }:

let
	CustomWmenu = pkgs.wmenu.overrideAttrs (oldAttrs: {
			src = pkgs.fetchFromGitHub {
			owner = "Dr-helicopter";
			repo = "wmenu";
			rev = "main";
			hash = "sha256-X0Q3IdIe5oLzF5TXbhV8JZmrLEIl5qGiNBi0kaAuVVY=";
		};
	});
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
		hyprland
		hyprcursor
		rose-pine-hyprcursor
		CustomWmenu
	];

	home.file = {
		".config/ls_color.sh".source = ./shell/ls_color.sh;
		".config/ffff/config.sh".source = ./shell/ffff_config.sh;

		"programs/.generic".text = ''
#!/usr/bin/env bash

			exec $(basename "$0")
		'';
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
}
