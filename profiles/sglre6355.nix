{
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./core.nix

    ../modules/commands/veracrypt.nix
    ../modules/commands/rtorrent.nix

    ../modules/development/claude-code.nix
    ../modules/development/devenv.nix
    ../modules/development/kubernetes.nix
    ../modules/development/podman.nix

    ../modules/desktop
    ../modules/applications/easyeffects.nix
    ../modules/applications/wine.nix
  ];

  home.username = lib.mkDefault "sglre6355";
  home.homeDirectory = lib.mkDefault "/home/sglre6355";

  home.packages = with pkgs; [
    ffmpeg
    gimp
    imagemagick
    poppler-utils

    android-tools
    google-cloud-sdk

    unar
  ];

  programs.zsh.initContent = /* zsh */ ''
    nix() {
      if [[ "$1" == develop ]]; then
        shift
        command nix develop "$@" -c zsh
      else
        command nix "$@"
      fi
    }
  '';

  programs.git = {
    enable = true;
    includes = [
      {
        contents = {
          user = {
            email = "sglre6355@gmail.com";
            name = "sglre6355";
          };
        };
      }
    ];
  };

  programs.codex.enable = true;

  programs.discord.enable = true;

  programs.obs-studio.enable = true;
}
