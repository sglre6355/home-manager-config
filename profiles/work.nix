{
  pkgs,
  ...
}:
{
  imports = [
    ./core.nix
  ];

  home.packages = with pkgs; [
    bruno
    slack
    code-cursor
  ];

  programs.google-chrome.enable = true;
}
