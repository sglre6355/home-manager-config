{
  pkgs,
  ...
}:
{
  imports = [
    ../modules/zsh.nix
    ../modules/xdg.nix
    ../modules/services/gpg-agent.nix

    ../modules/commands/bat.nix
    ../modules/commands/neovim.nix
    ../modules/commands/tmux.nix

    ../modules/development/git.nix
    ../modules/development/gh.nix

    ../modules/applications/firefox.nix
    ../modules/applications/wezterm.nix
  ];

  home.packages = with pkgs; [
    file
    jq
    ripgrep
    tealdeer
    tree

    zip
    unzip
    unrar
  ];

  programs.home-manager.enable = true;
}
