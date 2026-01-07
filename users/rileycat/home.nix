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
    coding.helix = true;
    coding.zed = true;

    productivity.libreOffice = true;

    terminal = {
      zsh = true;
    };

    unstable.enable = true;
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
