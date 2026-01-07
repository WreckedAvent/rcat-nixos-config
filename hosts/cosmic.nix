{pkgs, ...}: {
  services.desktopManager.cosmic.enable = true;

  services.displayManager.cosmic-greeter.enable = true;

  services.system76-scheduler.enable = true;

  environment.cosmic.excludePackages = with pkgs; [
    cosmic-edit
  ];

  environment.systemPackages = with pkgs; [
    kdePackages.kate
  ];
}
