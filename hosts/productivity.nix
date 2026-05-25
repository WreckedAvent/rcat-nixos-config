{
  pkgs,
  config,
  lib,
  ...
}: let
  opts = config.rcat.productivity;
  inherit (lib) mkIf mkEnableOption;
in {
  options.rcat.productivity = {
    dictd = mkEnableOption "dictd dictionary/translator";
    distrobox = mkEnableOption "distrobox distro emulator";
  };

  config = {
    services.dictd = with pkgs.dictdDBs;
      mkIf opts.dictd {
        enable = true;
        DBs = [eng2rus eng2deu wiktionary wordnet];
      };

    virtualisation.podman = mkIf opts.distrobox {
      enable = true;
      dockerCompat = true;
    };

    environment.systemPackages = lib.mkMerge [
      (mkIf opts.distrobox [pkgs.distrobox])
    ];
  };
}
