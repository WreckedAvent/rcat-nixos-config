{pkgs, ...}: {
  imports = [
    ../audio.nix
    ../boot.nix
    ../coding.nix
    ../kde.nix
    ../gaming.nix
    ../i18n.nix
    ../networking.nix
    ../productivity.nix
    ../utils.nix
  ];

  nix.package = pkgs.lixPackageSets.stable.lix;
  nix.settings.experimental-features = "nix-command flakes";

  services.printing.enable = true;

  catppuccin.enable = true;

  rcat = {
    coding.lsp = true;

    boot = {
      systemd-boot = true;
      useLatestKernel = true;
    };

    gaming = {
      steam = true;
      prism = true;
      nvidia = true;
      gamescope = true;
      recorder = true;
    };

    networking.hostName = "blackjack";
  };

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

  # TODO: i don't like this way of specifying ports
  networking.firewall = let
    minecraft-ports = {
      from = 25560;
      to = 25570;
    };
    stellaris-ports = {
      from = 17780;
      to = 17785;
    };
  in {
    allowedTCPPortRanges = [minecraft-ports stellaris-ports];
    allowedUDPPortRanges = [minecraft-ports stellaris-ports];
  };

  environment.systemPackages = with pkgs; [
    element-desktop
    distrobox
    heroic
  ];

  # the version this file was generated with
  system.stateVersion = "25.05";
}
