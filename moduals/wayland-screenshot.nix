{ pkgs, ... }:

{
	home.packages = [
		(pkgs.writeShellApplication {
			name = "wayland-screenshot.sh";

			runtimeInputs = [
				pkgs.grim
				pkgs.slurp
				pkgs.swappy
			];

			text = ''
				save_path="$HOME/Pictures/Screenshots"
				filename="$(date +'%Y.%m.%d-%a-%R:%S.grimshot.png')"

				case "''${1:-}" in
					-s)
						grim -g "$(slurp)" - | swappy -f -
						;;
					-f)
						grim - | swappy -f -
						;;
					*)
						mkdir -p "$save_path"
						grim "$save_path/$filename"
						;;
				esac
			'';
		})
	];
}

