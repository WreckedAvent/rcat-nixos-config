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

    ../kde.nix
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

    gaming = {
      launchers.steam = true;
      launchers.smm = true;
      hardware.amd = true;

      utils = {
        gamescope = true;
        recorder = true;
      };
    };

    networking.hostName = "blackjack";

    productivity = {
      spotify = true;
      youtube-music = true;
      distrobox = true;
    };
  };

  environment.systemPackages = with pkgs; [
    element-desktop
  ];

  # the version this file was generated with
  system.stateVersion = "25.05";
}
