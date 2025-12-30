{
  withSystem,
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
    pkgs = withSystem "x86_64-linux" ({pkgs, ...}: pkgs);
    modules = self.homeImports."rileycat@linux-any";
  };

  flake.nixosModules."rileycat" = {pkgs, ...}: {
    users.users.rileycat = {
      isNormalUser = true;
      description = "riley k";
      extraGroups = ["networkmanager" "wheel"];
      shell = pkgs.zsh;
    };

    programs = {
      zsh.enable = true;
    };
  };
}
