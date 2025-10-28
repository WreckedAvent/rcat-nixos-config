{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, unstable, home-manager }@inputs:
  let
    system = "x86_64-linux";
    pkgs-unstable = unstable.legacyPackages.${system};
  in {
    nixosConfigurations.blackjack = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit pkgs-unstable; }; 
      modules = [
        ./configuration.nix

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.rileycat = import ./rileycat.nix;
        }
      ];
    };
  };
}
