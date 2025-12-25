{pkgs, ...}: {
  home.packages = with pkgs; [
    nil
    nps
  ];

  programs.nix-index = {
    enable = true;
    enableZshIntegration = true;
  };
}
