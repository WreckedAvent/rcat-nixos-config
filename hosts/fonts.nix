{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.rcat.fonts;
  inherit (lib) mkIf mkMerge mkEnableOption;
in {
  options.rcat.fonts = {
    nerd = mkEnableOption "nerd fonts w/ ligatures";
  };

  config = {
    fonts.packages = mkMerge [
      (mkIf cfg.nerd (with pkgs.nerd-fonts; [
        fira-code
        caskaydia-cove
        inconsolata
        hasklug
        droid-sans-mono
      ]))

      (with pkgs; [
        noto-fonts
        liberation_ttf
        wineWowPackages.fonts
      ])
    ];
  };
}
