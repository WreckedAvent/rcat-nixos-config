{pkgs, ...}: {
  imports = [
    ../audio.nix
    ../boot.nix
    ../coding.nix
    ../cosmic.nix
    ../i18n.nix
    ../networking.nix
    ../productivity.nix
    ../utils.nix
  ];

  nix.package = pkgs.lixPackageSets.stable.lix;
  nix.settings.experimental-features = "nix-command flakes";

  services.printing.enable = true;

  rcat = {
    boot = {
      systemd-boot = true;
      useLatestKernel = true;
    };

    coding = {
      lsp = true;
    };

    productivity = {
      dictd = true;
    };

    networking = {
      hostName = "silverwolf";
    };
  };

  # the version this file was generated with
  system.stateVersion = "25.05";
}
