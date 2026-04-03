{
  description = ''
    A simple flake.

    This flake shows off several things beginners want to do, such as having
    unstable and stable nixpkgs, usage of home manager, and importing
    modules from another flake into the configuration.
   '';

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    catppuccin.url = "github:catppuccin/nix/release-25.11";
  };

  outputs = { self, nixpkgs, unstable, home-manager, catppuccin }:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    pkgs-unstable = unstable.legacyPackages.${system};
  in {
    ## nixos configuration
    nixosConfigurations.blackjack = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit pkgs-unstable; }; 
      modules = [
        ./configuration.nix
        catppuccin.nixosModules.catppuccin

        ## home manager nixos module
        # home-manager.nixosModules.home-manager
        # {
        #   home-manager.useGlobalPkgs = true;
        #   home-manager.useUserPackages = true;
        #   home-manager.users.rileycat.imports = [
        #     ./rileycat.nix
        #     catppuccin.homeModules.catppuccin
        #   ];
        # }
      ];
    };

    ## home manager standalone configuration
    homeConfigurations."rileycat" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        ./rileycat.nix
        catppuccin.homeModules.catppuccin
      ];
    };
  };
}
