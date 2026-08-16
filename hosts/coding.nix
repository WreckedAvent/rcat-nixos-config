{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.rcat.coding;
  inherit (lib) mkIf mkEnableOption mkDefault;
in {
  options.rcat.coding = {
    lsp = mkEnableOption "all relevant LSP servers";
  };

  config = {
    rcat.fonts.nerd = mkDefault true;
    environment.systemPackages = mkIf cfg.lsp (with pkgs; [
      gopls
      marksman
      omnisharp-roslyn
      rust-analyzer
      ty
      typescript-language-server
      zls
    ]);
  };
}
