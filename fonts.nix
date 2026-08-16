{lib, ...}: let
  inherit (lib) mkIf mkEnableOption mkMerge;
in {
  flake.genericModules.fonts = {
    pkgs,
    config,
    ...
  }: {
    options.rcat.fonts = {
      nerd = mkEnableOption "nerd fonts w/ ligatures";
    };

    config.fonts = {
      packages = mkMerge [
        (mkIf config.rcat.fonts.nerd (with pkgs.nerd-fonts; [
          fira-code
          caskaydia-cove
          inconsolata
          hasklug
          droid-sans-mono
          blex-mono
          zed-mono
        ]))

        (with pkgs; [
          ubuntu-classic
          noto-fonts
          noto-fonts-cjk-sans
          noto-fonts-color-emoji
        ])
      ];
    };
  };

  flake.nixosModules.fonts = {...}: {
    # liberation, noto, deja vu, few others
    fonts.enableDefaultPackages = true;

    fonts.fontconfig = {
      defaultFonts = {
        sansSerif = ["Noto Sans"];
        serif = ["Liberation Serif"];
        monospace = ["BlexMono"];
      };
    };
  };
}
