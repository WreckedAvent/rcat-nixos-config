{ lib, pkgs, ... }:

{
    environment.systemPackages = with pkgs; lib.mkDefault [
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
