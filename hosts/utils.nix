{
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = with pkgs;
    lib.mkMerge [
      [
        # global utils
        vim
        wget
        file
        which
        tree

        # system interrogation
        fastfetch
        dnsutils
        pciutils
        usbutils

        # monitor
        iftop
        htop
      ]

      (lib.mkIf pkgs.stdenv.hostPlatform.isLinux [
        ethtool
        psmisc

        iotop
      ])
    ];
}
