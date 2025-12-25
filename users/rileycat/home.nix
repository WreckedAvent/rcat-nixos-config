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

    productivity.libreOffice = true;

    terminal = {
      zsh = true;
      alacritty = true;
    };
  };

  home.packages = with pkgs; [
    # general utils
    bat
    btop
    eza
    fzf
    jq
    nnn
    ripgrep

    # gui utils
    usbimager
    easyeffects
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

  catppuccin.enable = true;

  systemd.user.startServices = "sd-switch";

  # minimum compatible home version
  home.stateVersion = "25.05";
}
