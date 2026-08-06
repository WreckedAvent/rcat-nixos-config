{
  pkgs,
  config,
  ...
}: {
  imports = [
    ../coding.nix
    ../nix-utils.nix
    ../nnn.nix
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

    environment.nnn = false;

    productivity.libreOffice = true;

    terminal.zsh = true;
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

  programs.vesktop = {
    enable = true;
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "rileycat";
        email = "deliciousfaith@live.net";
      };
      
      log.date =  "relative";
      format.pretty = "format:%h %Cblue%ad%Creset %ae %Cgreen%s%Creset"; 
    };
  };

  programs.difftastic = {
    enable = true;
    git.enable = true;
    options.display = "side-by-side";
  };

  programs.firefox = {
    enable = true;
    configPath = "${config.xdg.configHome}/mozilla/firefox";
  };

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
  };

  programs.home-manager.enable = true;

  catppuccin.enable = true;
  catppuccin.autoEnable = true;

  systemd.user.startServices = "sd-switch";

  # release version this file was generated with
  home.stateVersion = "25.05";
}
