{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.rcat.gaming;
  inherit (lib) mkIf mkEnableOption;
in {
  options.rcat.gaming = {
    steam = mkEnableOption "steam game library manager";
    lutris = mkEnableOption "lutris application launcher";
    nvidia = mkEnableOption "nvidia graphics driver support";
    amd = mkEnableOption "amd graphics driver support";
    gamescope = mkEnableOption "gamescope simple compositor";
    recorder = mkEnableOption "screen recording via gpu screen rec";
  };

  config = {
    assertions = [
      {
        assertion = !(cfg.amd && cfg.nvidia) && (cfg.amd || cfg.nvidia);
        message = "only one of amd or nvidia can be supported when importing gaming module";
      }
    ];

    programs.steam = mkIf cfg.steam {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      gamescopeSession.enable = cfg.gamescope;
    };

    programs.gamescope = mkIf cfg.gamescope {
      enable = true;
      capSysNice = true;
    };

    programs.gpu-screen-recorder.enable = cfg.recorder;

    environment.systemPackages = lib.mkMerge [
      (mkIf cfg.recorder [pkgs.gpu-screen-recorder-gtk])
      (mkIf cfg.lutris [pkgs.lutris])
    ];

    # Open GL
    hardware.graphics.enable = cfg.nvidia or cfg.amd;

    # Load nvidia driver for Xorg and Wayland
    services.xserver.videoDrivers = mkIf cfg.nvidia ["nvidia"];

    hardware.nvidia = mkIf cfg.nvidia {
      # Modesetting is required.
      modesetting.enable = true;

      # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
      # Enable this if you have graphical corruption issues or application crashes after waking
      # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
      # of just the bare essentials.
      powerManagement.enable = true;

      # Fine-grained power management. Turns off GPU when not in use.
      # Experimental and only works on modern Nvidia GPUs (Turing or newer).
      powerManagement.finegrained = false;

      # Use the NVidia open source kernel module (not to be confused with the
      # independent third-party "nouveau" open source driver).
      # Support is limited to the Turing and later architectures. Full list of
      # supported GPUs is at:
      # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
      # Only available from driver 515.43.04+
      open = true;

      # Enable the Nvidia settings menu,
      # accessible via `nvidia-settings`.
      nvidiaSettings = true;

      # Optionally, you may need to select the appropriate driver version for your specific GPU.
      package = config.boot.kernelPackages.nvidiaPackages.latest;
    };
  };
}
