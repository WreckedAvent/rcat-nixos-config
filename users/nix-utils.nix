{pkgs, ...}: {
  home.packages = with pkgs; [
    alejandra
    nil
    nixd
    nps
  ];

  programs.nix-index = {
    enable = true;
    enableZshIntegration = true;
  };
}
