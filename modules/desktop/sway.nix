{
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ../applications/wezterm.nix
  ];

  home.packages = with pkgs; [
    pulseaudio
    wl-clipboard
  ];

  i18n.inputMethod.fcitx5.waylandFrontend = true;

  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    config = rec {
      modifier = "Mod4";
      terminal = "wezterm";
      menu = "wofi --show drun -D key_expand=Tab";
      input = {
        "type:touchpad" = {
          tap = "enabled";
          natural_scroll = "enabled";
          middle_emulation = "enabled";
        };
      };
      output = {
        "*" = {
          bg = "#4e4e4e solid_color";
        };
      };
      bars = [
        {
          position = "top";
          statusCommand = "${pkgs.i3status}/bin/i3status";
          colors = {
            background = "#323232";
            statusline = "#ffffff";
            inactiveWorkspace = {
              border = "#323232";
              background = "#323232";
              text = "#5c5c5c";
            };
          };
        }
      ];
      focus.wrapping = "workspace";
      workspaceLayout = "tabbed";
      keybindings = lib.mkOptionDefault {
        "${modifier}+Tab" = "focus next";
        "${modifier}+Shift+Tab" = "focus prev";

        "Alt+Tab" = "workspace next";
        "Alt+Shift+Tab" = "workspace prev";

        "Alt+Control+Tab" = "focus output right";
        "Alt+Control+Shift+Tab" = "focus output left";

        "${modifier}+Control+Shift+Left" = "move workspace to output left";
        "${modifier}+Control+Shift+Down" = "move workspace to output down";
        "${modifier}+Control+Shift+Up" = "move workspace to output up";
        "${modifier}+Control+Shift+Right" = "move workspace to output right";

        "--locked XF86AudioRaiseVolume" =
          "exec ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +5%";
        "--locked XF86AudioLowerVolume" =
          "exec ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ -5%";
        "--locked XF86AudioMute" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle";
        "--locked XF86AudioMicMute" =
          "exec ${pkgs.pulseaudio}/bin/pactl set-source-mute @DEFAULT_SOURCE@ toggle";

        "--locked XF86AudioPlay" = "exec ${pkgs.playerctl}/bin/playerctl play-pause";
        "--locked XF86AudioNext" = "exec ${pkgs.playerctl}/bin/playerctl next";
        "--locked XF86AudioPrev" = "exec ${pkgs.playerctl}/bin/playerctl previous";

        "--locked XF86MonBrightnessUp" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set 10%+";
        "--locked XF86MonBrightnessDown" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set 10%-";
        "--locked XF86MonBrightnessUp+Shift" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set 5%+";
        "--locked XF86MonBrightnessDown+Shift" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set 5%-";

        # Snipping tool
        "${modifier}+Shift+s" =
          "exec ${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp)\" - | ${pkgs.wl-clipboard}/bin/wl-copy";

        # Lock screen
        "${modifier}+l" = "exec ${pkgs.swaylock}/bin/swaylock -f";
        # Lock screen and suspend
        "${modifier}+Shift+l" =
          "exec ${pkgs.systemd}/bin/systemctl suspend; ${pkgs.swaylock}/bin/swaylock -f";
      };
    };
  };

  programs.wofi.enable = true;

  programs.i3status = {
    enable = true;
    enableDefault = false;

    modules = {
      "ethernet _first_" = {
        enable = true;
        position = 0;
      };
      "wireless _first_" = {
        enable = true;
        position = 1;
      };
      "volume master" = {
        enable = true;
        position = 2;
        settings = {
          format = "V: %volume";
          format_muted = "V: muted (%volume)";
          device = "default";
          mixer = "Master";
          mixer_idx = 0;
        };
      };
      "battery all" = {
        position = 3;
        enable = true;
        settings = {
          format = "%status %percentage %remaining";
          format_down = "No battery";
          status_chr = "CHR";
          status_bat = "BAT";
          status_unk = "UNKNOWN";
          status_full = "FULL";
          status_idle = "IDLE";
          low_threshold = 15;
          threshold_type = "percentage";
          last_full_capacity = true;
        };
      };
      "tztime local" = {
        enable = true;
        position = 4;
        settings = {
          format = "%Y-%m-%d %H:%M:%S";
        };
      };
    };
  };

  services.swayidle =
    let
      lock = "${pkgs.swaylock}/bin/swaylock -f";
      display = status: "${pkgs.sway}/bin/swaymsg 'output * power ${status}'";
    in
    {
      enable = true;
      timeouts = [
        {
          timeout = 170;
          command = "${pkgs.libnotify}/bin/notify-send 'Locking in 10 seconds' -t 10000";
        }
        {
          timeout = 180;
          command = lock;
        }
        {
          timeout = 300;
          command = display "off";
          resumeCommand = display "on";
        }
        {
          timeout = 900;
          command = "${pkgs.systemd}/bin/systemctl suspend";
        }
      ];
      events = {
        before-sleep = (display "off") + "; " + lock;
        after-resume = display "on";
      };
    };

  programs.swaylock = {
    enable = true;
    settings = {
      color = "4e4e4e";
      show-failed-attempts = true;
    };
  };

  services.mako = {
    enable = true;
    settings = {
      default-timeout = 5000;
    };
  };
}
