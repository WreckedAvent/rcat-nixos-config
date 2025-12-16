{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.rcat.fonts;
  inherit (lib) mkIf mkEnableOption;
in {
  options.rcat.fonts = {
    nerd = mkEnableOption "nerd fonts w/ ligatures";
  };

  config = {
    fonts.packages = mkIf cfg.nerd (with pkgs.nerd-fonts; [
      fira-code
      caskaydia-cove
      inconsolata
      hasklug
      droid-sans-mono
    ]);
  };
}
