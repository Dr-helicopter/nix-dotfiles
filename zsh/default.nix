{ pkgs, theme, ... }: {
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
	home.file.".config/zsh".source = ./files;

	home.packages = with pkgs;[
		zsh
	];

}
