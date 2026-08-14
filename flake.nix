{
  description = ''
    A simple flake.

    This flake shows off several things beginners want to do, such as having
    unstable and stable nixpkgs, usage of home manager, and importing
    modules from another flake into the configuration.
   '';

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    catppuccin.url = "github:catppuccin/nix/release-26.05";
  };

  outputs = { self, nixpkgs, unstable, home-manager, catppuccin }:
  let
    pkg-args = {
      system = "x86_64-linux";
      # uncomment allow unfree packages
      # config.allowUnfree = true;
    };
    pkgs = import nixpkgs pkg-args;
    pkgs-unstable = import unstable pkg-args;
  in {
    inherit self;
    
    ## nixos configuration
    ##
    nixosConfigurations.blackjack = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit pkgs-unstable; }; 
      modules = [
        ./configuration.nix
        catppuccin.nixosModules.catppuccin

        ## home manager nixos module
        ## builds with nixos configuration, needs sudo elevation to switch
        ## 
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
    ## builds separately from nixos configuration, no elevation
    ##
    homeConfigurations."rileycat" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        ./rileycat.nix
        catppuccin.homeModules.catppuccin
      ];
    };
  };
}
