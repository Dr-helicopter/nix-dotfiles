{ config, pkgs, nixgl, lib, ... }:

{
	# Home Manager needs a bit of information about you and the paths it should
	# manage.



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

	];


	# Home Manager is pretty good at managing dotfiles. The primary way to manage
	# plain files is through 'home.file'.
	home.file = {
		# # Building this configuration will create a copy of 'dotfiles/screenrc' in
		# # the Nix store. Activating the configuration will then make '~/.screenrc' a
		# # symlink to the Nix store copy.
		# ".screenrc".source = dotfiles/screenrc;

		# # You can also set the file content immediately.
		# ".gradle/gradle.properties".text = ''
		#	 org.gradle.console=verbose
		#	 org.gradle.daemon.idletimeout=3600000
		# '';
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
	};

	# Let Home Manager install and manage itself.
	programs.home-manager.enable = true;


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
