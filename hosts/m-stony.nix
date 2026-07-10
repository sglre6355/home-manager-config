{
  pkgs,
  ...
}:
{
  imports = [
    ../profiles/reazon-holdings.nix

    ../modules/desktop/aerospace.nix
    ../modules/desktop/jankyborders.nix
    ../modules/desktop/karabiner.nix
  ];

  home.username = "keima_hara";
  home.homeDirectory = "/Users/keima_hara";

  home.packages = with pkgs; [
    coreutils
  ];

  home.stateVersion = "26.05";
}
