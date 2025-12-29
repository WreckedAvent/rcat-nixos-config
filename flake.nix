{
  description = "nixos config entrypoint for rcat home lab";

  inputs = {
    # both stable and unstable are pulled, but stable should be preferred
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    # a formatter closest to how i write nix
    alejandra = {
      url = "github:kamadorueda/alejandra/4.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # a pervasive and system-wide theme
    # CHORE: update to 25.11 when it is ready
    catppuccin.url = "github:catppuccin/nix/release-25.05";

    # opinionated flake layout to increase reusability
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    # obligatory for user profile management
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # tweaks for specific known hardware
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # for WSL hosts
    # CHORE: update to 25.11 when it is ready
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

    # pre-compiled nix pkgs database for e.g finding what package adds what binary
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "unstable";
    };
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} ({withSystem, ...}: {
      systems = ["x86_64-linux" "aarch64-linux"];

      perSystem = {
        system,
        inputs',
        ...
      }: {
        # override nixpkgs with a configured one
        # TODO: add a simple overlay to demonstrate usage
        _module.args.pkgs = import inputs.nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

        formatter = inputs.alejandra.defaultPackage.${system};
      };

      flake = {
        # a simple nixos module for using our pre-configured nixpkgs
        nixosModules.flake-nixpkgs = {config, ...}: {
          nixpkgs.pkgs = withSystem config.nixpkgs.hostPlatform.system (
            {pkgs, ...}:
              pkgs
          );
        };
      };

      imports = [
        # allow merging of hm configurations per flake part
        inputs.home-manager.flakeModules.home-manager

        ./users/rileycat

        ./hosts/silverwolf
        ./hosts/blackjack
        ./hosts/rileyrose
      ];
    });
}
