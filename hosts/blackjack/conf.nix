{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../audio.nix
    ../fonts.nix
    ../gaming.nix
    ../i18n.nix
    ../kde.nix
    ../utils.nix
  ];

  nix.package = pkgs.lixPackageSets.stable.lix;
  nix.settings.experimental-features = "nix-command flakes";

  boot.loader.efi.canTouchEfiVariables = true;
  # grub is momentarily easier to use with multi booting due to prober
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    useOSProber = true;
    devices = ["nodev"];
  };

  # boot.kernelPackages = pkgs.linuxPackages_latest;

  services.printing.enable = true;

  users.users.rileycat = {
    isNormalUser = true;
    description = "riley k";
    extraGroups = ["networkmanager" "wheel"];
  };

  gayming = {
    steam = true;
    nvidia = true;
  };

  networking.hostName = "blackjack"; # Define your hostname.
  networking.networkmanager.enable = true;
  services.openssh.enable = true;

  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
