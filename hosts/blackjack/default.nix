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
    unstable.lib.nixosSystem {
      modules =
        [
          ./conf.nix
          ./hardware.nix
        ]
        ++ config.rcat.flake.nixosDefaults;
    };
}
