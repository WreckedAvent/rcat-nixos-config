{
  inputs,
  withSystem,
  ...
}: {
  perSystem = {system, ...}: {
    # configure nixpkgs
    _module.args.pkgs = import inputs.nixpkgs {
      inherit system;
      config.allowUnfree = true;

      overlays = [
        (self: super: {
          # forcefully overwrite packages that don't let us do it nicely
          alejandra = inputs.alejandra.defaultPackage.${system};
        
          cosmic-osd = inputs.unstable.legacyPackages.${system}.cosmic-osd;
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
