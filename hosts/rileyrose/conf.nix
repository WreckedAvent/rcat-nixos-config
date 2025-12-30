{...}: {
  imports = [
    ../productivity.nix
    ../utils.nix
  ];

  rcat.productivity.dictd = true;

  networking.hostName = "wsl";
  nix.settings.experimental-features = "nix-command flakes";

  users.groups.kvm = {};
  users.groups.libvirtd.members = ["rileycat"];

  programs.virt-manager.enable = true;

  virtualisation = {
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
    docker = {
      enable = true;
      enableOnBoot = true;
      autoPrune.enable = true;
    };
  };

  wsl = {
    enable = true;
    defaultUser = "rileycat";
    startMenuLaunchers = true;
  };

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
  };

  # systemd.services.docker-desktop-proxy.script = lib.mkForce ''${config.wsl.wslConf.automount.root}/wsl/docker-desktop/docker-desktop-user-distro proxy --docker-desktop-root ${config.wsl.wslConf.automount.root}/wsl/docker-desktop "C:\Program Files\Docker\Docker\resources"'';

  # do not change
  system.stateVersion = "24.05";
}
