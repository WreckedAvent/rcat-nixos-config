{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.rcat.boot;
  inherit (lib) mkIf mkEnableOption mkDefault;
in {
  options.rcat.boot = {
    useLatestKernel = mkEnableOption "the latest linux kernel";
    grub = mkEnableOption "GRUB2 bootloader";
    limine = mkEnableOption "limine simple bootloader";
    systemd-boot = mkEnableOption "recommended systemd-boot loader";
  };

  config = {
    boot.loader.efi.canTouchEfiVariables = true;
    rcat.boot.systemd-boot = mkDefault true;
    boot.kernelPackages = if cfg.useLatestKernel
      then pkgs.linuxPackages_latest
      else pkgs.linuxPackages_6_18;

    boot.loader.systemd-boot = mkIf cfg.systemd-boot {
      enable = true;
      memtest86.enable = true;
      configurationLimit = 5;
      edk2-uefi-shell.enable = true;
    };

    boot.loader.grub = mkIf cfg.grub {
      enable = true;
      efiSupport = true;
      useOSProber = true;
      devices = ["nodev"];
    };

    boot.loader.limine = mkIf cfg.limine {
      enable = true;
      extraConfig = ''
        remember_last_entry: yes
      '';
      extraEntries = ''
        /Ubuntu
          protocol: linux
          path: uuid(3B69-5A81):/boot/vmlinuz-6.14.0-33-generic
          module_path: uuid(3B69-5A81):/boot/initrd.img-6.14.0-33-generic
      '';
    };
  };
}
