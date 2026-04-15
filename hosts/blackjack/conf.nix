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
      useLatestKernel = false;
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

  # TODO: i don't like this way of specifying ports
  networking.firewall = let
    minecraft-ports = {
      from = 25560;
      to = 25570;
    };
  in {
    allowedTCPPortRanges = [minecraft-ports];
    allowedUDPPortRanges = [minecraft-ports];
  };

  environment.systemPackages = with pkgs; [
    element-desktop
  ];

  # the version this file was generated with
  system.stateVersion = "25.05";
}
