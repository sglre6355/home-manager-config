{
  pkgs,
  ...
}:
{
  imports = [
    ./core.nix
  ];

  home.packages = with pkgs; [
    slack
    code-cursor
  ];

  programs.google-chrome.enable = true;
}
