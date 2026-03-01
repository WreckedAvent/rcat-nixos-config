{pkgs, ...}: {
  # gnome and its display manager
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # de bloat
  # services.gnome.core-apps.enable = false;
  services.gnome.core-developer-tools.enable = false;
  services.gnome.games.enable = false;
  
  environment.gnome.excludePackages = with pkgs; [ gnome-tour gnome-user-docs ];
  environment.systemPackages = with pkgs; [ kdePackages.kate ];
}
