{ self, inputs, ... }:

{
  flake.nixosConfigurations.blackjack = with inputs; nixpkgs.lib.nixosSystem {
    modules = [
      ./conf.nix
      ./hardware.nix

      catppuccin.nixosModules.catppuccin

      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        #
        # enable with weird hm errors, grep for this extension to see what the problem is
        # home-manager.backupFileExtension = "hm-backup";
        # 
        home-manager.users.rileycat.imports = with self.modules.homeManager; [
          users-rileycat
          catppuccin.homeModules.catppuccin
        ];
      }
    ];
  };
}
