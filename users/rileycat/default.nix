{
  inputs,
  self,
  ...
}:
with inputs; {
  imports = [
    ../unstable.flake-part.nix
  ];

  flake.homeImports."rileycat" = [
    ./home.nix
    self.homeModules.unstable-packages

    catppuccin.homeModules.catppuccin
    nix-index-database.homeModules.default
  ];

  flake.homeImports."rileycat@linux-any" =
    self.homeImports."rileycat"
    ++ [
      ./linux-any.nix
    ];

  flake.homeConfigurations."rileycat" = home-manager.lib.homeManagerConfiguration {
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
    modules = self.homeImports."rileycat@linux-any";
  };
}
