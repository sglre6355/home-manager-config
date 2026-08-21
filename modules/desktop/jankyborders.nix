{
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin {
    # Highlights the focused window, since macOS gives no visual cue for
    # which tiled window has focus. Colors match the kanagawa colorscheme
    # (crystal blue) used elsewhere in this config.
    launchd.agents.jankyborders = {
      enable = true;
      config = {
        ProgramArguments = [
          (lib.getExe' pkgs.jankyborders "borders")
          "style=round"
          "width=5.0"
          "hidpi=on"
          # "active_color=0xc0ff00f2"
          # "inactive_color=0xff0080ff"
        ];
        KeepAlive = true;
        RunAtLoad = true;
      };
    };
  };
}
