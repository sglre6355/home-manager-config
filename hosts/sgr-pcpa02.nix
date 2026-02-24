{
  ...
}:
{
  imports = [
    ../profiles/sglre6355.nix
    ../profiles/work.nix
  ];

  home.stateVersion = "26.05";

  wayland.windowManager.sway.config = {
    output = {
      "AOC 24B3HA2 AVKR69A005771" = {
        pos = "1920 0";
      };
      "AOC 24B3HA2 AVKR69A005233" = {
        pos = "0 0";
      };
    };
    workspaceOutputAssign = [
      {
        workspace = "10";
        output = "AOC 24B3HA2 AVKR69A005233";
      }
    ];
  };
}
