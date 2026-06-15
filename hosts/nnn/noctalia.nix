{lib, ...}: let
  inherit (lib) mkDefault;
in {
  # docs suggest these should be enabled
  networking.networkmanager.enable = mkDefault true;
  hardware.bluetooth.enable = mkDefault true;
  services.power-profiles-daemon.enable = mkDefault true;
  services.upower.enable = mkDefault true;
}
