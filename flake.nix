{
  description = "Home Manager configuration of helic";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixgl = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wmenu.url = "github:Dr-helicopter/wmenu";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nixgl,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          (final: prev: {
            wmenu = inputs.wmenu.packages.${system}.default;
          })
        ];
      };
    in
    {
      homeConfigurations = {
        "nixman" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          modules = [ ./home.nix ];
          extraSpecialArgs = {
            inherit nixgl;
            machine = "nixman";
            theme = import ./theme.nix;
          };
        };

        "Gandalf" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          modules = [
            ./home.nix
            ./device-specific/Gandalf.nix
            #./non-nixos.nix
          ];
          extraSpecialArgs = {
            inherit nixgl;
            machine = "Gandalf";
            theme = import ./theme.nix;
          };
        };
      };
    };
}
