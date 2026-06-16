{pkgs, ...}: {
  imports = [
    ../audio.nix
    ../boot.nix
    ../coding.nix
    ../games.nix
    ../i18n.nix
    ../networking.nix
    ../nix.nix
    ../productivity.nix
    ../utils.nix

    ../nnn
  ];
  services.printing.enable = true;

  catppuccin.enable = true;
  catppuccin.autoEnable = true;

  rcat = {
    coding.lsp = true;

    boot = {
      systemd-boot = true;
      useLatestKernel = true;
    };

    games = {
      minecraft-prism = true;
      stellaris-heroic = true;
    };

    gaming = {
      launchers.steam = true;
      launchers.smm = true;
      hardware.nvidia = true;
      utils = {
        gamescope = true;
        recorder = true;
      };
    };

    networking.hostName = "blackjack";

    productivity.distrobox = true;
  };

  environment.systemPackages = with pkgs; [
    element-desktop
    spotify-player
    kdePackages.audiotube
  ];

  # the version this file was generated with
  system.stateVersion = "25.05";
}
