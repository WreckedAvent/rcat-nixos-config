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
    
    networking = {
      hostName = "blackjack";
      openPorts = {
        minecraft = true;
        stellaris = true;
      };
    };

    productivity.distrobox = true;
  };

  environment.systemPackages = with pkgs; [
    element-desktop
    heroic
  ];

  # the version this file was generated with
  system.stateVersion = "25.05";
}
