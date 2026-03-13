{
  inputs,
  config,
  ...
}: {
  rcat.flake.unfreePkgs = [
    "nvidia-settings"
    "nvidia-x11"
    "steam"
    "steam-unwrapped"
  ];

  flake.nixosConfigurations.blackjack = with inputs;
    nixpkgs.lib.nixosSystem {
      modules =
        [
          ./conf.nix
          ./hardware.nix
        ]
        ++ config.rcat.flake.nixosDefaults;
    };
}
