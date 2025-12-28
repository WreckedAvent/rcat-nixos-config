{pkgs, ...}: {
  networking.hostName = "wsl";
  nix.settings.experimental-features = "nix-command flakes";
  users.groups.kvm = {};

  users.users.rileycat = {
    isNormalUser = true;
    extraGroups = ["wheel" "kvm"];
    shell = pkgs.zsh;
  };

  users.groups.libvirtd.members = ["rileycat"];

  environment = {
    systemPackages = with pkgs; [
      git
      wget
      bat
      zsh
      fastfetch
      universal-ctags
    ];
  };

  programs = {
    zsh.enable = true;

    virt-manager.enable = true;

    git = {
      enable = true;
      prompt.enable = true;
    };
  };

  services = {
    dictd = {
      enable = true;
      DBs = with pkgs.dictdDBs; [eng2rus eng2deu];
    };
  };

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
