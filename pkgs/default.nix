{self, ...}: let
  getPkg = name: "${self}/pkgs/${name}/package.nix";
in {
  flake.nixosModules.customPackages = {
    pkgs,
    lib,
    config,
    ...
  }: let
    inherit (lib) flip mkIf;
    callPackage = flip pkgs.callPackage {};

    # modules might not be installed, check for existance
    cfg = config.rcat;
    ai =
      if cfg ? ai
      then cfg.ai.enable
      else false;
  in {
    environment.systemPackages = mkIf ai [
      (callPackage (getPkg "omnisharp-roslyn"))
    ];
  };
}
