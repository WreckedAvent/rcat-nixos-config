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
          cosmic-pkgs-names = [
            "bg"
            "osd"
            "term"
            "idle"
            "edit"
            "comp"
            "store"
            "randr"
            "panel"
            # "icon"
            "files"
            # "reader"
            "player"
            # "session"
            "greeter"
            # "ext-ctl"
            "applets"
            "settings"
            "launcher"
            # "protocols"
            "applibrary"
            # "screenshot"
            # "wallpapers"
            # "ext-tweaks"
            "notifications"
            # "ext-calculator"
            # "settings-deamon"
            "workspaces-epoch"
          ];
          
          unusual-cosmic-pkgs-names = [
            "xdg-desktop-portal-cosmic"
          ];

          unstable-pkgs = inputs.unstable.legacyPackages.${system};

          prefixCosmic = builtins.map (pkg: "cosmic-" + pkg);
          cosmic-pkgs = (prefixCosmic cosmic-pkgs-names) ++ unusual-cosmic-pkgs-names;
          
        in
          # 2. turn str[] into attrset[str, str]
          lib.genAttrs cosmic-pkgs
          # 3. attrset[str, str] into attrset[str, pkg]
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
