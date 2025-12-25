{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # global utils
    vim
    wget
    file
    which
    tree

    # system interrogation
    fastfetch
    psmisc
    ethtool
    dnsutils
    pciutils
    usbutils

    # monitor
    iotop
    iftop
    htop
  ];
}
