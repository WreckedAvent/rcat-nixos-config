{
  inputs,
  self,
  ...
}:
with inputs; {
  flake.homeImports."rileycat" = [
    ./home.nix
    self.homeModules.unstable-packages

    catppuccin.homeModules.catppuccin
    nix-index-database.homeModules.default
  ];

  flake.homeConfigurations."rileycat" = home-manager.lib.homeManagerConfiguration {
    packages = nixpkgs.legacyPackages.x86_64-linux;
    modules = self.homeImports."rileycat";
  };
}
