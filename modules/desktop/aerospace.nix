{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf pkgs.stdenv.isDarwin {
    programs.aerospace = {
      enable = true;
      # AeroSpace itself is installed by the Homebrew cask in system-config;
      # installing it from nixpkgs would move the app bundle on every update
      # and macOS would keep revoking its accessibility permission.
      package = null;

      settings = {
        config-version = 2;

        default-root-container-layout = "tiles";

        on-focused-monitor-changed = [ "move-mouse monitor-lazy-center" ];

        mode.main.binding =
          let
            focus = "focus --boundaries-action wrap-around-the-workspace";
          in
          {
            cmd-enter = "exec-and-forget open -na ${config.programs.wezterm.package}/Applications/WezTerm.app";
            cmd-d = "exec-and-forget open -a ${pkgs.raycast}/Applications/Raycast.app";

            cmd-left = "${focus} left";
            cmd-down = "${focus} down";
            cmd-up = "${focus} up";
            cmd-right = "${focus} right";
            # Karabiner-Elements remaps Cmd+Tab to F18 and Cmd+Shift+Tab to F19
            # to bypass the macOS app switcher
            f18 = "${focus} right";
            f19 = "${focus} left";

            alt-tab = "workspace --wrap-around next";
            alt-shift-tab = "workspace --wrap-around prev";
            alt-ctrl-tab = "focus-monitor --wrap-around next";
            alt-ctrl-shift-tab = "focus-monitor --wrap-around prev";

            alt-ctrl-shift-left = "move-workspace-to-monitor --wrap-around left";
            alt-ctrl-shift-right = "move-workspace-to-monitor --wrap-around right";

            cmd-shift-left = "move left";
            cmd-shift-down = "move down";
            cmd-shift-up = "move up";
            cmd-shift-right = "move right";

            cmd-1 = "workspace 1";
            cmd-2 = "workspace 2";
            cmd-3 = "workspace 3";
            cmd-4 = "workspace 4";
            cmd-5 = "workspace 5";
            cmd-6 = "workspace 6";
            cmd-7 = "workspace 7";
            cmd-8 = "workspace 8";
            cmd-9 = "workspace 9";
            cmd-0 = "workspace 10";

            cmd-shift-1 = "move-node-to-workspace 1";
            cmd-shift-2 = "move-node-to-workspace 2";
            cmd-shift-3 = "move-node-to-workspace 3";
            cmd-shift-4 = "move-node-to-workspace 4";
            cmd-shift-5 = "move-node-to-workspace 5";
            cmd-shift-6 = "move-node-to-workspace 6";
            cmd-shift-7 = "move-node-to-workspace 7";
            cmd-shift-8 = "move-node-to-workspace 8";
            cmd-shift-9 = "move-node-to-workspace 9";
            cmd-shift-0 = "move-node-to-workspace 10";

            cmd-f = "fullscreen";
            cmd-w = "layout accordion horizontal vertical";
            cmd-e = "layout tiles horizontal vertical";
            cmd-shift-space = "layout floating tiling";
            cmd-shift-q = "close";
            cmd-shift-c = "reload-config";

            cmd-shift-minus = "resize smart -50";
            cmd-shift-equal = "resize smart +50";

            # Snipping tool
            cmd-shift-s = "exec-and-forget screencapture -i -c";
          };
      };
    };

    # The native screenshot shortcuts are symbolic hotkeys handled by the
    # window server before AeroSpace can intercept them, so they fire in
    # addition to the Cmd-Shift-3/4/5 bindings below. Cmd-Shift-S replaces
    # them.
    targets.darwin.defaults."com.apple.symbolichotkeys".AppleSymbolicHotKeys = {
      "28" = {
        enabled = false; # Save picture of screen (Cmd+Shift+3)
      };
      "30" = {
        enabled = false; # Save picture of selected area (Cmd+Shift+4)
      };
      "184" = {
        enabled = false; # Screenshot and recording options (Cmd+Shift+5)
      };
    };
  };
}
