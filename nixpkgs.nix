{
  inputs,
  withSystem,
  lib,
  config,
  ...
}: {
  perSystem = {system, ...}: {
    # configure nixpkgs
    _module.args.pkgs = import inputs.nixpkgs {
      inherit system;
      config.allowUnfreePredicate = pkg:
        builtins.elem (lib.getName pkg) config.rcat.flake.unfreePkgs;

      # forcefully overwrite packages that don't let us do it nicely
      overlays = [
        (self: super: {
          alejandra = inputs.alejandra.defaultPackage.${system};
        })
      ];
    };
  };

  # use configured nixpkgs
  flake.nixosModules.nixpkgs = {config, ...}: {
    nixpkgs.pkgs = withSystem config.nixpkgs.hostPlatform.system (
      {pkgs, ...}:
        pkgs
    );
  };
}
