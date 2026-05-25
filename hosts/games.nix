{
  lib,
  config,
  ...
}: let
   opts = config.rcat.games;
   inherit (lib) mkIf mkEnableOption;
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
    rcat.gaming = {
      prism = opts.minecraft-prism;
      heroic = opts.stellaris-heroic;
    };

    rcat.networking = {
      openPorts.minecraft = opts.minecraft-prism;
      openPorts.stellaris = opts.stellaris-heroic;
    };
  };
}
