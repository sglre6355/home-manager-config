{
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./core.nix

    ../modules/development/claude-code.nix
    ../modules/development/devenv.nix
  ];

  home.packages = with pkgs; [
    slack
    (lib.lowPrio minikube)
    skaffold
    gcc
    go
    nodejs
  ];
}
