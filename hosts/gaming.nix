{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.rcat.gaming;
  inherit (lib) mkIf mkEnableOption mkOption types;
in {
  options.rcat.gaming = {
    launchers = mkOption {
      description = "launchers and instance managers";
      type = types.submodule {
        options = {
          steam = mkEnableOption "steam game library manager";
          lutris = mkEnableOption "lutris application launcher";
          prism = mkEnableOption "prism minecraft instance manager";
          heroic = mkEnableOption "heoric GOG instance manager";
        };
      };
    };
    
    hardware = mkOption  {
      description = "hardware tweaks and configurations";
      type = types.submodule {
        options = {
          nvidia = mkEnableOption "nvidia graphics driver support";
          amd = mkEnableOption "amd graphics driver support";
        };
      };
    };

    utils = mkOption {
      description = "utilities useful in a gaming context";
      type = types.submodule {
        options = {
          gamescope = mkEnableOption "gamescope simple compositor";
          recorder = mkEnableOption "screen recording via gpu screen rec";
        };
      };
    };
  };

  config = {
    assertions = [
      {
        assertion = !(cfg.hardware.amd && cfg.hardware.nvidia) && (cfg.hardware.amd || cfg.hardware.nvidia);
        message = "only one of amd or nvidia can be supported when importing gaming module";
      }
    ];

    programs.steam = mkIf cfg.launchers.steam {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      gamescopeSession.enable = cfg.utils.gamescope;
    };

    programs.gamescope = mkIf cfg.utils.gamescope {
      enable = true;
      capSysNice = true;
    };

    programs.gpu-screen-recorder.enable = cfg.utils.recorder;

    environment.systemPackages = lib.mkMerge [
      (mkIf cfg.utils.recorder [pkgs.gpu-screen-recorder-gtk])
      (mkIf cfg.launchers.lutris [pkgs.lutris])
      (mkIf cfg.launchers.prism [pkgs.prismlauncher])
      (mkIf cfg.launchers.heroic [pkgs.heroic])
    ];

    # Open GL
    hardware.graphics.enable = cfg.hardware.nvidia or cfg.hardware.amd;

    # Load nvidia driver for Xorg and Wayland
    services.xserver.videoDrivers = mkIf cfg.hardware.nvidia ["nvidia"];

    hardware.nvidia = mkIf cfg.hardware.nvidia {
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
