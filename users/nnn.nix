{
  config,
  lib,
  ...
}: let
  cfg = config.rcat.environment;
  inherit (lib) mkIf mkEnableOption;
in {
  options.rcat.environment = {
    nnn = mkEnableOption "noctailia+niri+nix combo user environment";
  };

  config = mkIf cfg.nnn {
    programs.noctalia = {
      enable = true;

      settings = {
        bar.main = {
          margin_ends = 60;
          start = [
            "launcher"
            "spacer"
            "clock"
            "spacer"
            "volume"
            "media"
            "audio_visualizer"
          ];

          center = [
            "active_window"
            "spacer"
            "workspaces"
          ];

          end = [
            "tray"
            "notifications"
            "clipboard"
            "spacer"
            "sysmon"
            "network"
            "bluetooth"
            "brightness"
            "battery"
            "spacer"
            "control-center"
            "session"
          ];
        };

        widget.media.hide_when_no_media = true;
        widget.audio_visualizer.show_when_idle = false;

        dock = {
          enabled = true;
          auto_hide = true;
          active_monitor_only = true;
          reserve_space = false;
        };

        theme = {
          mode = "dark";
          source = "builtin";
          builtin = "Catppuccin";
        };

        idle.behavior = {
          lock = {
            enabled = true;
            timeout = 300;
            command = "noctalia:session lock";
          };

          screen-off = {
            enabled = true;
            timeout = 600;
            command = "noctalia:dpms-off";
            resume_command = "noctalia:dpms-on";
          };

          lock-and-suspend = {
            enabled = true;
            timeout = 900;
            command = "noctalia:session lock-and-suspend";
          };
        };

        shell = {
          ui_scale = 1.15;
          avatar_path = "/home/rileycat/nixos-config/img/chloe away.png";
          niri_overview_type_to_launch_enabled = true;
        };

        location = {
          auto_locate = true;
        };

        wallpaper = {
          enabled = true;
          default.path = "/home/rileycat/nixos-config/img/amy2.png";
        };
      };
    };

    xdg.configFile."niri/config.kdl".source = ./niri.kdl;
  };
}
