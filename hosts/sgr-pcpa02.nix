{
  pkgs,
  ...
}:
{
  imports = [
    ../profiles/sglre6355.nix
    ../profiles/reazon-holdings.nix

    ../modules/applications/wine.nix
  ];

  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    audacity
    prismlauncher
    osu-lazer-bin
  ];

  wayland.windowManager.sway.config = {
    output = {
      "AOC 24B3HA2 AVKR69A005771" = {
        mode = "1920x1080@120Hz";
        pos = "0 0";
      };
      "AOC 24B3HA2 AVKR69A005233" = {
        mode = "1920x1080@120Hz";
        pos = "1920 0";
      };
    };
    workspaceOutputAssign = [
      {
        workspace = "1";
        output = "AOC 24B3HA2 AVKR69A005233";
      }
      {
        workspace = "10";
        output = "AOC 24B3HA2 AVKR69A005771";
      }
    ];
  };
}
