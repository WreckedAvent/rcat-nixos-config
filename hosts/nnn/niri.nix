{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.niri.enable = true;
  security.polkit.enable = true; # polkit
  services.gnome.gnome-keyring.enable = true; # secret service
  security.pam.services.swaylock = {};

  environment.systemPackages = with pkgs; [
    fuzzel
    # todo: configure
    swaylock
    mako
    # greeter
    tuigreet
    # x11
    xwayland-satellite
  ];

  services.greetd = {
    enable = true;
    settings = {
      default_session = let
        niri = lib.getExe config.programs.niri.package;
        tui-greet = lib.getExe pkgs.tuigreet;
      in {
        command = "${tui-greet} --time --cmd  ${niri}";
        user = "greeter";
      };
    };
  };

  # NixOS otherwise injects a stripped PATH via Environment= on the niri.service
  # unit which shadows the imported user-manager PATH. Disabling the default
  # lets niri inherit the full PATH set up by niri-session.
  systemd.user.services.niri.enableDefaultPath = false;
}
