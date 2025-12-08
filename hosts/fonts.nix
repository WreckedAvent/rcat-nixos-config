{ pkgs, ... }:
{
   fonts.packages = with pkgs; with nerd-fonts; [
    fira-code
    caskaydia-cove
    inconsolata
    hasklug
    droid-sans-mono
  ];
}
