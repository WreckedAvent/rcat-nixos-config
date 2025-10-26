{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgsUnstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.blackjack = nixpkgs.lib.nixosSystem {
      modules = [
        ./configuration.nix  
      ];
    };
  };
}
