{
	home.sessionPath = [ 
		"$HOME/scripts"
	];

	home.file = {
		".config/ls_color.sh".source = ./shell/ls_color.sh;
		".config/ffff/config.sh".source = ./shell/ffff_config.sh;
		"scripts/open.sh".source = ./shell/open.sh;
		"scripts/menu".source = ./shell/menu;
		"scripts/todo".source = ./shell/todo;
		"scripts/torctl".source = ./shell/torctl;

		"scripts/home-switch.sh" = {
			source = ./shell/home-scripts.sh;
			executable = true;
		};

		"programs/.generic" = {
			text = ''
			#!/usr/bin/env bash

			exec $(basename "$0")
			'';
			executable = true;
		};
	};
}
