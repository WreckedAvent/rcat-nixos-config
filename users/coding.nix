{
  lib,
  config,
  ...
}: let
  opts = config.rcat.coding;
  inherit (lib) mkIf mkEnableOption;
in {
  options.rcat.coding = {
    helix = mkEnableOption "helix opinionated 'post-modern' editor";
  };

  config = {
    programs.helix = mkIf opts.helix {
      enable = true;
      defaultEditor = true;
      settings = {
        editor = {
          line-number = "relative";
          end-of-line-diagnostics = "hint";
          rulers = [80 120];

          indent-guides = {
            character = "⸽";
            render = true;
          };

          inline-diagnostics = {
            cursor-line = "error"; # Show inline diagnostics when the cursor is on the line
            other-lines = "disable"; # Don't expand diagnostics unless the cursor is on the line
          };

          lsp = {
            display-messages = true;
            display-inlay-hints = true;
          };
        };
      };
    };
  };
}
