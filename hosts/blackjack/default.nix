{
  inputs,
  config,
  self,
  ...
}: {
  rcat.flake.unfreePkgs = [
    "steam"
    "steam-unwrapped"
    "claude-code"
  ];

  flake.nixosConfigurations.blackjack = with inputs;
    nixpkgs.lib.nixosSystem {
      modules =
        [
          ./conf.nix
          ./hardware.nix
          
          ({ pkgs, ... }:
          {
            environment.systemPackages = [
              (pkgs.callPackage "${self}/pkgs/omnisharp-roslyn/package.nix" { })
            ];
          })

        ]
        ++ config.rcat.flake.nixosDefaults;
    };
}
