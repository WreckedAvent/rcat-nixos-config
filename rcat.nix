{lib, ...}: let
  inherit (lib) mkOption types;
in {
  options.rcat.flake = {
    homeDefaults = mkOption {
      description = ''
        List of nixos modules from flake inputs that should generally be used by hosts in this configuration.
        Styles, flake-wide nixos modules, nixpkgs configurations, obligatory user definitions, etc.
      '';
      example = "[ inputs.stylix.nixosModules.default ]";
      type = types.listOf types.deferredModule;
      default = [];
    };

    nixosDefaults = mkOption {
      description = "List of home modules from flake inputs that should generally be used by users in this configuration";
      example = "[ inputs.cattpuciin.homeModules.default ]";
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
