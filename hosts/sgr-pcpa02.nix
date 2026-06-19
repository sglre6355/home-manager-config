{
  pkgs,
  ...
}:
{
  imports = [
    ../profiles/sglre6355.nix
    ../profiles/work.nix
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
        pos = "1920 0";
      };
      "YCT DP-BF162S-B Unknown" = {
        mode = "1920x1080@60Hz";
        pos = "0 0";
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
