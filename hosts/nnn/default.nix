{pkgs, ...}: {
  imports = [
    ./noctalia.nix
    ./niri.nix
  ];

  environment.systemPackages = with pkgs; [
    # kde packages
    kdePackages.kate
    kdePackages.kcalc
    kdePackages.kdenlive

    # styling qt
    kdePackages.qtstyleplugin-kvantum
    kdePackages.qt6ct
  ];
}
