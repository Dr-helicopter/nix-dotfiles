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
		homeConfigurations."nixman" = home-manager.lib.homeManagerConfiguration {
			inherit pkgs;

			# Specify your home configuration modules here, for example,
			# the path to your home.nix.
			modules = [ ./home.nix ];

			extraSpecialArgs = {
				inherit nixgl;
				machine = "nixman";
				theme = import ./theme.nix;
			};
			# Optionally use extraSpecialArgs
			# to pass through arguments to home.nix
		};

		homeConfigurations."Gandalf" = home-manager.lib.homeManagerConfiguration {
			inherit pkgs;

			modules = [
				./home.nix
				./non-nixos.nix
			];

			extraSpecialArgs = {
				inherit nixgl;
				machine = "Gandalf";
				theme = import ./theme.nix;
			};
		};
    };
}
