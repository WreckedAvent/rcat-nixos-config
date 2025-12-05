{ withSystem, inputs, ... }:

{
  flake.nixosConfigurations.silverwolf = with inputs; nixpkgs.lib.nixosSystem {
    modules = [
      ./conf.nix
      ./hardware.nix

      catppuccin.nixosModules.catppuccin
      nixos-hardware.nixosModules.framework-amd-ai-300-series

      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        #
        # enable with weird hm errors, grep for this extension to see what the problem is
        # home-manager.backupFileExtension = "hm-backup";
        # 
        home-manager.users.rileycat.imports = [
          ../../rileycat.nix
          catppuccin.homeModules.catppuccin
        ];
      }
    ];
  };
}
