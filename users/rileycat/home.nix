{
  config,
  pkgs,
  ...
}: {
  home.username = "rileycat";
  home.homeDirectory = "/home/rileycat";

  home.packages = with pkgs; [
    # general utils
    bat
    btop
    eza
    fzf
    jq
    nnn
    ripgrep

    # nix
    nps

    # gui utils
    usbimager
    easyeffects

    # language
    aspell
    aspellDicts.en
    hunspell
    hunspellDicts.en_US

    # productivity
    libreoffice-qt-fresh
    nil
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

  programs.nix-index = {
    enable = true;
    enableZshIntegration = true;
  };

  # needs a profile
  # programs.thunderbird = {
  #   enable = true;
  # };

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
    plugins = [
      {
        name = "vi-mode";
        src = pkgs.zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
    ];
  };

  programs.helix = {
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

  catppuccin.enable = true;

  systemd.user.startServices = "sd-switch";

  # minimum compatible home version
  home.stateVersion = "25.05";
}
