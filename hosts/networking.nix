{
  config,
  lib,
  ...
}: let
  opts = config.rcat.networking;
  inherit (lib) mkOption types;
in {
  options.rcat.networking = {
    hostName = mkOption {
      type = types.str;
      description = "the name of the host";
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

    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };
}
