{ config, pkgs, ... }:

{
  home.username = "rileycat";
  home.homeDirectory = "/home/rileycat";
  
  home.packages = with pkgs; [
    ripgrep
    jq
    bat
    btop
    thunderbird
    fzf

    kdePackages.qtstyleplugin-kvantum
    kdePackages.plasma-browser-integration
  ];

  programs.vesktop.enable = true;

  programs.git = {
    enable = true;
    settings.user = {
      name = "rileycat";
      email = "deliciousfaith@live.net";
    };
  };
  
  programs.difftastic = {
    git.enable = true;
    options.display = "side-by-side";
  };

  programs.starship = {
    enable = true;
  };

  programs.firefox = {
    enable = true;
  };
  catppuccin.firefox = {
    enable = true;
    force = true;
  };

  programs.alacritty = {
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
  
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
  };

  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      editor.line-number = "relative";
    };
  };

  catppuccin.enable = true;

  systemd.user.startServices = "sd-switch";

  # minimum compatible home version
  home.stateVersion = "25.05";
}
