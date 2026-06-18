{pkgs, ...}: {
  imports = [
    ../coding.nix
    ../nix-utils.nix
    ../productivity.nix
    ../terminal.nix
  ];

  home.username = "rileycat";
  home.homeDirectory = "/home/rileycat";

  rcat = {
    coding = {
      direnv = true;
      helix = true;
      zed = true;
    };

    productivity.libreOffice = true;

    terminal.zsh = true;

    # unstable.enable = true;
  };

  home.packages = with pkgs; [
    bat
    btop
    eza
    thunderbird
    jq
    nnn
    ripgrep
  ];

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultOptions = [
      "--height=50%"
      "--border"
      "--layout=reverse"
      "--preview='bat --style=numbers --color=always {}'"
    ];
  };

  programs.vesktop.enable = true;

  programs.git = {
    enable = true;
    settings.user = {
      name = "rileycat";
      email = "deliciousfaith@live.net";
    };
  };

  programs.difftastic = {
    enable = true;
    git.enable = true;
    options.display = "side-by-side";
  };

  programs.firefox = {
    enable = true;
    # You are currently using the legacy default (`".mozilla/firefox"`) because `home.stateVersion` is less than "26.05".
    # To silence this warning and keep legacy behavior, set:
    #   programs.firefox.configPath = ".mozilla/firefox";
    # To adopt the new default behavior, set:
    #   programs.firefox.configPath = "${config.xdg.configHome}/mozilla/firefox";
    #
    # To migrate to the XDG path, move `~/.mozilla/firefox` to
    # `$XDG_CONFIG_HOME/mozilla/firefox` and remove the old directory.
    # Native messaging hosts are not moved by this option change.
    configPath = "./mozilla/firefox";
    # did you read the comment?
  };

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
  };

  programs.home-manager.enable = true;

  catppuccin.enable = true;
  catppuccin.autoEnable = true;

  programs.swaylock = {
    enable = true;
    settings = {
      image = "/home/rileycat/nixos-config/img/amy.png";
    };
  };

  programs.noctalia = {
    enable = true;

    settings = {
      # This may also be a string or path to a .toml file.
      bar.main = {
        margin_ends = 60;
        start = ["launcher" "spacer" "clock" "spacer" "volume" "media" "audio_visualizer"];
        center = ["active_window" "spacer" "workspaces"];
        end = [
          "tray"
          "notifications"
          "clipboard"
          "spacer"
          "sysmon"
          "network"
          "bluetooth"
          "brightness"
          "battery"
          "spacer"
          "control-center"
          "session"
        ];
      };

      widget.media.hide_when_no_media = true;
      widget.audio-visuualizer.show_when_idle = false;

      dock = {
        enabled = true;
        auto_hide = true;
        active_monitor_only = true;
        reserve_space = false;
      };

      theme = {
        mode = "dark";
        source = "builtin";
        builtin = "Catppuccin";
      };

      location = {
        auto_locate = true;
      };

      wallpaper = {
        enabled = true;
        default.path = "/home/rileycat/nixos-config/img/amy2.png";
      };
    };
  };

  xdg.configFile."niri/config.kdl".source = ./niri.kdl;

  systemd.user.startServices = "sd-switch";

  # release version this file was generated with
  home.stateVersion = "25.05";
}
