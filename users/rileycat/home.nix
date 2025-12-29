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

  # needs a profile
  # programs.thunderbird = {
  #   enable = true;
  # };

  programs.firefox = {
    enable = true;
  };

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
  };

  catppuccin.enable = true;

  systemd.user.startServices = "sd-switch";

  programs.home-manager.enable = true;

  # minimum compatible home version
  home.stateVersion = "25.05";
}
