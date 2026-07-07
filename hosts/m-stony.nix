{
  pkgs,
  ...
}:
{
  imports = [
    ../profiles/reazon-holdings.nix

    ../modules/desktop/aerospace.nix
  ];

  home.username = "keima_hara";
  home.homeDirectory = "/Users/keima_hara";

  home.packages = with pkgs; [
    coreutils
  ];

  home.stateVersion = "26.05";
}
