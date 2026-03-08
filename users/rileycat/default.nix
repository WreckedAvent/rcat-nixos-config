{
  withSystem,
  inputs,
  self,
  config,
  ...
}:
with inputs; {
  flake.homeImports."rileycat" =
    [./home.nix]
    ++ config.rcat.flake.homeDefaults;

  flake.homeImports."rileycat@linux-any" =
    self.homeImports."rileycat"
    ++ [./linux-any.nix];

  flake.homeConfigurations."rileycat" = home-manager.lib.homeManagerConfiguration {
    pkgs = withSystem "x86_64-linux" ({pkgs, ...}: pkgs);
    modules = self.homeImports."rileycat";
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
