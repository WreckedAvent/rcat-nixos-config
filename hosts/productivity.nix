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
    spotify = mkEnableOption "spotify front-end (spotify-player)";
    youtube-music = mkEnableOption "YT music front-end (audiotube)";
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
      (mkIf opts.spotify [pkgs.spotify-player])
      (mkIf opts.youtube-music [pkgs.kdePackages.audiotube])
    ];
  };
}
