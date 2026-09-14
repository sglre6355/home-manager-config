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
      "Acer Technologies KG271U TATSJ0018522" = {
        mode = "2560x1440@144Hz";
        pos = "0 0";
      };
      "YCT DP-BF162S-B Unknown" = {
        mode = "1920x1080@60Hz";
        pos = "320 1440";
      };
    };
    workspaceOutputAssign = [
      {
        workspace = "10";
        output = "YCT DP-BF162S-B Unknown";
      }
    ];
  };
}
