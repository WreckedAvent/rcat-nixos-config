{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.rcat.coding;
  inherit (lib) mkIf mkEnableOption mkDefault;
in {
  imports = [
    ./fonts.nix
  ];

  options.rcat.coding = {
    lsp = mkEnableOption "all relevant LSP servers";
  };

  config = {
    rcat.fonts.nerd = mkDefault true;
    environment.systemPackages = mkIf cfg.lsp (with pkgs; [
      rust-analyzer
      zls
      ty
      marksman
      typescript-language-server
      gopls
      omnisharp-roslyn
    ]);
  };
}
