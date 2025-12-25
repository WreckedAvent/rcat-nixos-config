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
    libreOffice = mkEnableOption "latest gtk based libre office";
  };

  config = {
    home.packages = with pkgs;
      mkIf opts.libreOffice [
        # language
        aspell
        aspellDicts.en
        hunspell
        hunspellDicts.en_US

        # productivity
        libreoffice-qt-fresh
      ];
  };
}
