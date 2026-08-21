{
  pkgs,
  ...
}:
{
  imports = [
    ../profiles/hatena.nix

    ../modules/desktop/aerospace.nix
    ../modules/desktop/jankyborders.nix
    ../modules/desktop/karabiner.nix
  ];

  home.username = "intern595";
  home.homeDirectory = "/Users/intern595";

  home.packages = with pkgs; [
    coreutils
  ];

  home.stateVersion = "26.05";
}
