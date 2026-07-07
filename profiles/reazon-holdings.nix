{
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./core.nix

    ../modules/development/claude-code.nix
    ../modules/development/devenv.nix
  ];

  home.packages = with pkgs; [
    bruno
    slack
    bun
    uv
    go
    golangci-lint
    google-cloud-sdk
  ];

  programs.git.includes = [
    {
      contents = {
        commit.gpgSign = lib.mkForce false;
        user = {
          email = "keima_hara@reazon.jp";
          name = "keima_hara";
        };
      };
    }
  ];

  programs.google-chrome.enable = true;
}
