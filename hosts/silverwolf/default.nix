{
  inputs,
  config,
  ...
}: {
  flake.nixosConfigurations.silverwolf = with inputs;
    nixpkgs.lib.nixosSystem {
      modules =
        [
          ./conf.nix
          ./hardware.nix

          nixos-hardware.nixosModules.framework-amd-ai-300-series
        ]
        ++ config.rcat.flake.nixosDefaults;
    };
}
