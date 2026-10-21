{ pkgs, ... }:
let
	grim = "${pkgs.grim}/bin/grim";
	slurp = "${pkgs.slurp}/bin/slurp";
	swappy= "${pkgs.swappy}/bin/swappy";
in 
{
	home.packages = [
		(pkgs.writeShellScriptBin "wayland-screenshot.sh" ''
		save_path=~/Pictures/Screenshots

		name() {
			date +"%G.%m.%d-%a-%R:%S.grimshot.png"
		}

		case $1
		in
			-s)
				${grim} -g "$(${slurp})" - | ${swappy} -f -
				;;
			-f)
				${grim} - | ${swappy} -f -
				;;
			*)
				${grim} $save_path/"$(name)"
				 ;;
		esac
		'')
	];
}
