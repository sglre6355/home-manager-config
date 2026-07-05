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
  ];

  programs.google-chrome.enable = true;
}
