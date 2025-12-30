{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.blackjack = with inputs;
    nixpkgs.lib.nixosSystem {
      modules = [
        ./conf.nix
        ./hardware.nix

        self.nixosModules.flake-nixpkgs
        self.nixosModules."rileycat"

        catppuccin.nixosModules.catppuccin
      ];
    };
}
