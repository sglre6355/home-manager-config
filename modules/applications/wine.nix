{
  pkgs,
  lib,
  ...
}:
{
  config = lib.mkIf pkgs.stdenv.isLinux {
    home.packages = with pkgs; [
      wineWow64Packages.stable
      winetricks
    ];
  };
}
