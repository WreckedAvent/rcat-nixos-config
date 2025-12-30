{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.wsl = self.nixosConfigurations.rileyrose;
  flake.nixosConfigurations.rileyrose = with inputs;
    nixpkgs.lib.nixosSystem {
      modules = [
        ./conf.nix
        ./hardware.nix

        self.nixosModules.flake-nixpkgs
        self.nixosModules."rileycat"

        nixos-wsl.nixosModules.default

        home-manager.nixosModules.home-manager
        {
          home-manager.users."rileycat".imports = self.homeImports."rileycat";
        }
      ];
    };
}
