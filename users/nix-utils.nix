{pkgs, ...}: {
  home.packages = with pkgs; [
    alejandra
    nil
    nps
  ];

  programs.nix-index = {
    enable = true;
    enableZshIntegration = true;
  };
}
