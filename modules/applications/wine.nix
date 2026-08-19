{
  pkgs,
  lib,
  ...
}:
{
  config = lib.mkIf pkgs.stdenv.hostPlatform.isLinux {
    home.packages = with pkgs; [
      wineWow64Packages.stable
      winetricks
    ];
  };
}
