{
  lib,
  config,
  pkgs,
  ...
}: let
  opts = config.rcat.terminal;
  inherit (lib) mkIf mkEnableOption;
in {
  options.rcat.terminal = {
    alacritty = mkEnableOption "alacritty";
    zsh = mkEnableOption "z shell";
  };

  config = {
    programs.starship = {
      enable = true;
    };

    programs.alacritty = mkIf opts.alacritty {
      enable = true;
      settings = {
        env.TERM = "xterm-256color";
        font = {
          size = 12;
        };
        scrolling.multiplier = 5;
        selection.save_to_clipboard = true;
      };
    };

    programs.zsh = mkIf opts.zsh {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      plugins = [
        {
          name = "vi-mode";
          src = pkgs.zsh-vi-mode;
          file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
        }
      ];
    };
  };
}
