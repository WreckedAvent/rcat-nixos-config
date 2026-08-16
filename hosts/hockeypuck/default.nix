{
  inputs,
  config,
  self,
  ...
}: {
  flake.darwinConfigurations.hockeypuck = self.darwinConfigurations."Rileys-Mac-mini";
  flake.darwinConfigurations."Rileys-Mac-mini" = with inputs;
    nix-darwin.lib.darwinSystem {
      modules =
        [
          ./conf.nix

          home-manager.darwinModules.home-manager
          {
            system.configurationRevision = self.rev or self.dirtyRev or null;
            home-manager.users."rileycat".imports = self.homeImports."rileycat";
          }
        ]
        ++ config.rcat.flake.darwinDefaults;
    };
}
