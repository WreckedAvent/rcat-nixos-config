{pkgs, ...}: {
  imports = [
    ../audio.nix
    ../boot.nix
    ../coding.nix
    ../kde.nix
    ../games.nix
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

    games = {
      minecraft-prism = true;
      stellaris-heroic = true;
    };

    gaming = {
      launchers.steam = true;
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
  ];

  # the version this file was generated with
  system.stateVersion = "25.05";
}
