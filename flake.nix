{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs, unstable }@inputs:
  let
    system = "x86_64-linux";
    pkgs-unstable = unstable.legacyPackages.${system};
  in {
    nixosConfigurations.blackjack = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit pkgs-unstable; }; 
      modules = [
        ./configuration.nix  
      ];
    };
  };
}
