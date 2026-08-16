{
  withSystem,
  inputs,
  self,
  config,
  ...
}: let
  hmConfig = inputs.home-manager.lib.homeManagerConfiguration;
  user = "rileycat";
in {
  flake.homeImports.${user} =
    [./home.nix]
    ++ config.rcat.flake.homeDefaults;

  flake.homeImports."${user}@linux-any" =
    self.homeImports.${user}
    ++ [./linux-any.nix];

  flake.homeConfigurations.${user} = hmConfig {
    pkgs = withSystem "x86_64-linux" ({pkgs, ...}: pkgs);
    modules = self.homeImports."${user}@linux-any";
  };

  flake.nixosModules.${user} = {pkgs, ...}: {
    users.users.${user} = {
      isNormalUser = true;
      description = "riley k";
      extraGroups = ["networkmanager" "wheel"];
      shell = pkgs.zsh;
    };

    programs.zsh.enable = true;
  };

  flake.darwinModules.${user} = {pkgs, ...}: {
    users.users.${user} = {
      name = "rileyk";
      createHome = false;
      home = "/Users/rileyk";
      description = "Riley K";
      shell = pkgs.zsh;
    };

    programs.zsh.enable = true;
  };
}
