{inputs, ...}: {
  flake.homeModules.unstable-packages = {
    pkgs,
    lib,
    config,
    ...
  }: let
    opts = config.rcat.unstable;
    inherit (lib) mkIf mkEnableOption;

    system = pkgs.stdenv.hostPlatform.system;
    unstable-pkgs = inputs.unstable.legacyPackages.${system};
  in {
    options.rcat.unstable.enable = mkEnableOption "unstable packages";

    config = mkIf opts.enable {
      programs.zed-editor.package = unstable-pkgs.zed-editor;
    };
  };
}
