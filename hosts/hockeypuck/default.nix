{
  inputs,
  config,
  self,
  ...
}: {
  flake.darwinConfigurations.hockeypuck = self.darwinConfigurations."Rileys-Mac-mini";
  flake.darwinConfigurations."Rileys-Mac-mini" = with inputs;
    nix-darwin.lib.darwinSystem {
      modules = [
        {
          system.configurationRevision = self.rev or self.dirtyRev or null;
        }
        ./conf.nix
      ];
    };
}
