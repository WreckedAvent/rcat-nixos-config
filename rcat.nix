{lib, ...}: let
  inherit (lib) mkOption types;
in {
  options.flake.genericModules = mkOption {
    type = types.lazyAttrsOf types.deferredModule;
    default = [];
  };

  options.rcat.flake = {
    homeDefaults = mkOption {
      description = "List of home managers conventional to use by home configurations.";
      example = "[ inputs.stylix.nixosModules.default ]";
      type = types.listOf types.deferredModule;
      default = [];
    };

    nixosDefaults = mkOption {
      description = "List of nixos modules conventional to use by nixos configurations.";
      example = "[ inputs.cattpucin.homeModules.default ]";
      type = types.listOf types.deferredModule;
      default = [];
    };

    darwinDefaults = mkOption {
      description = "List of darwin modules conventional to use by darwin configurations.";
      example = "[  ]";
      type = types.listOf types.deferredModule;
      default = [];
    };

    unfreePkgs = mkOption {
      description = "List of package names allowed to be unfree.";
      example = ''["steam" ]'';
      type = types.listOf types.str;
      default = [];
    };
  };
}
