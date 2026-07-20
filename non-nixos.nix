{ pkgs, nixgl, ... }:

{
	home.packages = [
		nixgl.packages.${pkgs.stdenv.hostPlatform.system}.default
	];
}
