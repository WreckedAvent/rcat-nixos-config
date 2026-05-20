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

  systemd.user.startServices = "sd-switch";

  # release version this file was generated with
  home.stateVersion = "25.05";
}
