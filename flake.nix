{
	description = "Home Manager configuration of helic";

	inputs = {
		# Specify the source of Home Manager and Nixpkgs.
		nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		nixgl = {
    		url = "github:nix-community/nixGL";
    		inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { nixpkgs, home-manager, nixgl, ... }:
	let
		system = "x86_64-linux";
		pkgs = nixpkgs.legacyPackages.${system};
	in
	{
		homeConfigurations."helic" = home-manager.lib.homeManagerConfiguration {
			inherit pkgs;

			# Specify your home configuration modules here, for example,
			# the path to your home.nix.
			modules = [ ./home.nix ];

			extraSpecialArgs = {
				inherit nixgl;
			};
			# Optionally use extraSpecialArgs
			# to pass through arguments to home.nix
		};
		homeConfigurations.helic-non-nix = home-manager.lib.homeManagerConfiguration {
			inherit pkgs;

			modules = [
				./home.nix
				./non-nixos.nix
			];

			extraSpecialArgs = {
				inherit nixgl;
			};
		};
    };
}
