{ pkgs, ... }: {
  services.xserver.desktopManager.cinnamon.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.enable = true;

  fonts.packages = with pkgs; [
    noto-fonts
    liberation_ttf
    wineWowPackages.fonts
  ];
}
