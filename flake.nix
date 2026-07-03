{
  description = ''
    Nix-based entry point for rileycat homelab.

    This flake is flake-parts based; each host and user defines their own flake module.
    Configuration beginning with `rcat` is defined within this flake's directory.
  '';

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    # a formatter closest to how i write nix
    alejandra = {
      url = "github:kamadorueda/alejandra/4.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # a pervasive and system-wide theme
    catppuccin = {
      url = "github:catppuccin/nix/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # pre-compiled nix pkgs database for e.g finding what package adds what binary
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    flake-parts,
    catppuccin,
    nix-index-database,
    nixpkgs,
    noctalia,
    ...
  } @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux" "aarch64-linux"];

      perSystem = {pkgs, ...}: {
        formatter = pkgs.alejandra;
      };

      rcat.flake = {
        nixosDefaults = [
          self.nixosModules.nixpkgs
          self.nixosModules."rileycat"

          catppuccin.nixosModules.default

          ({
            pkgs,
            lib,
            config,
            ...
          }: let
            opts = config.rcat.noctalia;
            sys = pkgs.stdenv.hostPlatform.system;
          in {
            options.rcat.noctalia.enable = lib.mkEnableOption "noctalia shell";

            config.environment.systemPackages = lib.mkIf opts.enable [
              noctalia.packages.${sys}.default
            ];
          })
        ];

        homeDefaults = [
          catppuccin.homeModules.default
          nix-index-database.homeModules.default
          noctalia.homeModules.default

          {
            nix.channels = {inherit nixpkgs;};
          }
        ];
      };

      imports = [
        ./rcat.nix
        ./nixpkgs.nix

        ./users/rileycat

        ./hosts/silverwolf
        ./hosts/blackjack
        ./hosts/rileyrose
      ];
    };
}
