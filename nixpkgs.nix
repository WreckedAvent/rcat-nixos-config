{
  inputs,
  withSystem,
  lib,
  ...
}: {
  perSystem = {system, ...}: {
    # configure nixpkgs
    _module.args.pkgs = import inputs.nixpkgs {
      inherit system;
      config.allowUnfree = true;

      # forcefully overwrite packages that don't let us do it nicely
      overlays = [
        (self: super: {
          alejandra = inputs.alejandra.defaultPackage.${system};
        })

        (_: _: let
          usual-cosmic-pkg-names = [
            "bg"
            "osd"
            "term"
            "idle"
            "edit"
            "comp"
            "store"
            "randr"
            "panel"
            "icon"
            "files"
            "reader"
            "player"
            "session"
            "greeter"
            "ext-ctl"
            "applets"
            "settings"
            "launcher"
            "protocols"
            "applibrary"
            "screenshot"
            "wallpapers"
            "ext-tweaks"
            "notifications"
            "settings-deamon"
            "workspaces-epoch"
          ];

          unusual-cosmic-pkg-names = [
            "xdg-desktop-portal-cosmic"
          ];

          unstable-pkgs = inputs.unstable.legacyPackages.${system};

          prefixCosmic = builtins.map (pkg: "cosmic-" + pkg);
          all-cosmic-pkg-names = (prefixCosmic usual-cosmic-pkg-names) ++ unusual-cosmic-pkg-names;
        in
          lib.genAttrs all-cosmic-pkg-names
          (pkg-name: unstable-pkgs.${pkg-name}))
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
