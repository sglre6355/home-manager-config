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
    waypipe
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
          command = "${pkgs.waybar}/bin/waybar";
        }
      ];
      focus.wrapping = "workspace";
      workspaceLayout = "tabbed";
      keybindings = lib.mkOptionDefault {
        "${modifier}+Tab" = "focus next";
        "${modifier}+Shift+Tab" = "focus prev";

        "Alt+Tab" = "workspace next_on_output";
        "Alt+Shift+Tab" = "workspace prev_on_output";

        "Alt+Control+Tab" = "focus output right";
        "Alt+Control+Shift+Tab" = "focus output left";

        "${modifier}+Control+Shift+Left" = "move workspace to output left";
        "${modifier}+Control+Shift+Down" = "move workspace to output down";
        "${modifier}+Control+Shift+Up" = "move workspace to output up";
        "${modifier}+Control+Shift+Right" = "move workspace to output right";

        "--locked XF86AudioRaiseVolume" =
          "exec ${pkgs.pipewire}/bin/wpctl set-sink-volume @DEFAULT_SINK@ 5%+";
        "--locked XF86AudioLowerVolume" =
          "exec ${pkgs.pipewire}/bin/wpctl set-sink-volume @DEFAULT_SINK@ 5%-";
        "--locked XF86AudioMute" = "exec ${pkgs.pipewire}/bin/wpctl set-mute @DEFAULT_SINK@ toggle";
        "--locked XF86AudioMicMute" = "exec ${pkgs.pipewire}/bin/wpctl set-mute @DEFAULT_SOURCE@ toggle";

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

  programs.waybar = {
    enable = true;

    settings = [
      {
        layer = "top";
        position = "top";

        modules-left = [
          "sway/workspaces"
        ];

        modules-right = [
          "network"
          "custom/separator"
          "wireplumber"
          "custom/separator"
          "battery"
          "custom/no_battery_indicator"
          "custom/separator"
          "clock"
          "custom/separator"
          "idle_inhibitor"
          "tray"
        ];

        "custom/separator" = {
          format = "┃";
          tooltip = false;
        };

        "custom/no_battery_indicator" = {
          exec = ''
            ls /sys/class/power_supply/BAT* >/dev/null 2>&1 || echo "No battery"
          '';
          format = "{}";
        };

        network = {
          format = "{ifname}";
          format-wifi = "W: {essid} ({signalStrength}%)";
          format-ethernet = "E: {ifname}";
          format-disconnected = "No network";
        };

        wireplumber = {
          format = "V: {volume}%";
          format-muted = "V: muted ({volume}%)";
          scroll-step = 5;
        };

        battery = {
          format = "BAT {capacity}% {time}";
          format-discharging = "BAT {capacity}% {time}";
          format-charging = "CHR {capacity}% {time}";
          format-plugged = "IDLE {capacity}%";
          format-full = "FULL {capacity}%";

          format-time = "{H}h {m}m";

          states = {
            warning = 15;
            critical = 5;
          };
        };

        clock = {
          format = "{:%Y-%m-%d %H:%M:%S}";
          interval = 1;
          tooltip = false;
        };

        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
          tooltip = true;
        };

        tray = {
          icon-size = 15;
          show-passive-items = true;
          spacing = 5;
        };
      }
    ];

    style = ''
      * {
        border-radius: 1;
        font-family: monospace;
        font-size: 11px;
        min-height: 17px;
      }

      window#waybar {
        background: #323232;
        color: #ffffff;
        margin: 0px;
        padding: 0px;
      }

      #workspaces button {
        color: #5c5c5c;
        min-width: 17px;
        margin: 0px;
        padding: 0px 0.5px;
      }

      #workspaces button:hover {
        border: 1px solid #323232;
      }

      #workspaces button.visible {
        background: #5f676a;
        color: #ffffff;
      }

      #workspaces button.focused {
        background: #285577;
        color: #ffffff;
        border: 1px solid #4c7899;
      }

      #workspaces button.urgent {
        background: #900000;
        color: #ffffff;
        border: 1px solid #900000;
      }

      #custom-separator {
        color: #4c4c4c;
        margin: 0 2px;
      }

      #network {
        color: #00ff00;
      }
      #network.disconnected,
      #network.disabled {
        color: #ff0000;
      }

      #wireplumber.sink-muted {
        color: #ffff00;
      }

      #battery.warning {
        color: #ffff00;
      }
      #battery.critical {
        color: #ff0000;
      }

      #idle_inhibitor {
        margin-right: 10px;
      }
    '';
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
