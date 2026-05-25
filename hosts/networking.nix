{
  config,
  lib,
  ...
}: let
  opts = config.rcat.networking;
  inherit (lib) mkOption mkIf mkEnableOption types;
  ports = {
    minecraft = {
      from = 25560;
      to = 25570;
    };
    stellaris = {
      from = 17780;
      to = 17785;
    };
  };
in {
  options.rcat.networking = {
    hostName = mkOption {
      type = types.str;
      description = "the name of the host";
    };

    openPorts = mkOption {
      description = "ports to open in the firewall for various reasons";
      type = types.submodule {
        options = {
          minecraft = mkEnableOption "minecraft ports";
          stellaris = mkEnableOption "stellaris ports";
        };
      };
    };
  };

  config = {
    assertions = [
      {
        assertion = opts.hostName != null;
        message = "rcat.networking.hostname is required when importing networking module";
      }
    ];

    networking.hostName = opts.hostName;
    networking.networkmanager.enable = true;
    services.openssh.enable = true;
    services.resolved.enable = true;

    networking.firewall = let
      open-ports = lib.mkMerge [
        (mkIf opts.openPorts.minecraft [ports.minecraft])
        (mkIf opts.openPorts.stellaris [ports.stellaris])
      ];
    in {
      allowedTCPPortRanges = open-ports;
      allowedUDPPortRanges = open-ports;
    };

    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };
}
