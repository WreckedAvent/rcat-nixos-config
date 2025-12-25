{
  pkgs,
  lib,
  ...
}: {
  # x11 is enabled for now
  services.xserver.enable = lib.mkDefault true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.displayManager.sddm = {
    enable = true;
    theme = lib.mkOrder 900 "catppuccin-mocha-mauve";
  };

  services.desktopManager.plasma6.enable = true;

  environment.systemPackages = with pkgs;
  with kdePackages; [
    # 1st party
    kate
    plasma-systemmonitor
    kcalc
    kdenlive

    # 3rd party
    qtstyleplugin-kvantum
    plasma-browser-integration
    catppuccin-sddm
  ];
}
