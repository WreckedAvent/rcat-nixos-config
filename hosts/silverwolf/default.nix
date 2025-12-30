{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.silverwolf = with inputs;
    nixpkgs.lib.nixosSystem {
      modules = [
        ./conf.nix
        ./hardware.nix

        self.nixosModules.flake-nixpkgs
        self.nixosModules."rileycat"

        catppuccin.nixosModules.catppuccin

        nixos-hardware.nixosModules.framework-amd-ai-300-series
      ];
    };
}
