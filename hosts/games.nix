{
  lib,
  config,
  ...
}: let
  opts = config.rcat.games;
  inherit (lib) mkEnableOption mkDefault;
in {
  imports = [
    ./gaming.nix
    ./networking.nix
  ];

  options.rcat.games = {
    minecraft-prism = mkEnableOption "minecraft launched thru prism";
    stellaris-heroic = mkEnableOption "stellaris (GOG) launched thru heroic";
  };

  config = {
    rcat.gaming.launchers = {
      prism = mkDefault opts.minecraft-prism;
      heroic = mkDefault opts.stellaris-heroic;
    };

    rcat.networking = {
      openPorts.minecraft = mkDefault opts.minecraft-prism;
      openPorts.stellaris = mkDefault opts.stellaris-heroic;
      openPorts.satisfactory = mkDefault true;
    };
  };
}
