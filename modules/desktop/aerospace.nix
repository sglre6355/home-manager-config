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
        # Counterpart of sway's `workspaceLayout = "tabbed"`; accordion is
        # AeroSpace's closest equivalent.
        default-root-container-layout = "accordion";

        on-focused-monitor-changed = [ "move-mouse monitor-lazy-center" ];

        mode.main.binding =
          let
            focus = "focus --boundaries-action wrap-around-the-workspace";
          in
          {
            alt-enter = "exec-and-forget open -na ${config.programs.wezterm.package}/Applications/WezTerm.app";

            alt-j = "${focus} left";
            alt-k = "${focus} down";
            alt-l = "${focus} up";
            alt-semicolon = "${focus} right";
            alt-left = "${focus} left";
            alt-down = "${focus} down";
            alt-up = "${focus} up";
            alt-right = "${focus} right";

            alt-shift-j = "move left";
            alt-shift-k = "move down";
            alt-shift-l = "move up";
            alt-shift-semicolon = "move right";
            alt-shift-left = "move left";
            alt-shift-down = "move down";
            alt-shift-up = "move up";
            alt-shift-right = "move right";

            alt-1 = "workspace 1";
            alt-2 = "workspace 2";
            alt-3 = "workspace 3";
            alt-4 = "workspace 4";
            alt-5 = "workspace 5";
            alt-6 = "workspace 6";
            alt-7 = "workspace 7";
            alt-8 = "workspace 8";
            alt-9 = "workspace 9";
            alt-0 = "workspace 10";

            alt-shift-1 = "move-node-to-workspace 1";
            alt-shift-2 = "move-node-to-workspace 2";
            alt-shift-3 = "move-node-to-workspace 3";
            alt-shift-4 = "move-node-to-workspace 4";
            alt-shift-5 = "move-node-to-workspace 5";
            alt-shift-6 = "move-node-to-workspace 6";
            alt-shift-7 = "move-node-to-workspace 7";
            alt-shift-8 = "move-node-to-workspace 8";
            alt-shift-9 = "move-node-to-workspace 9";
            alt-shift-0 = "move-node-to-workspace 10";

            alt-f = "fullscreen";
            alt-w = "layout accordion horizontal vertical";
            alt-e = "layout tiles horizontal vertical";
            alt-shift-space = "layout floating tiling";
            alt-shift-q = "close";
            alt-shift-c = "reload-config";

            alt-shift-minus = "resize smart -50";
            alt-shift-equal = "resize smart +50";

            alt-tab = "workspace --wrap-around next";
            alt-shift-tab = "workspace --wrap-around prev";
            alt-ctrl-tab = "focus-monitor --wrap-around next";
            alt-ctrl-shift-tab = "focus-monitor --wrap-around prev";

            alt-ctrl-shift-left = "move-workspace-to-monitor --wrap-around prev";
            alt-ctrl-shift-right = "move-workspace-to-monitor --wrap-around next";

            # Snipping tool
            alt-shift-s = "exec-and-forget screencapture -i -c";
          };
      };
    };
  };
}
