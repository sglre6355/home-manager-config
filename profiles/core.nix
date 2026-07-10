{
  config,
  pkgs,
  ...
}:
{
  imports = [
    ../modules/zsh.nix
    ../modules/xdg.nix
    ../modules/services/gpg-agent.nix

    ../modules/commands/bat.nix
    ../modules/commands/fzf.nix
    ../modules/commands/neovim.nix
    ../modules/commands/tmux.nix
    ../modules/commands/zoxide.nix

    ../modules/development/git.nix
    ../modules/development/gh.nix

    ../modules/applications/firefox.nix
    ../modules/applications/junction.nix
    ../modules/applications/wezterm.nix
  ];

  home.sessionPath = [ "${config.home.homeDirectory}/.local/bin" ];

  home.packages = with pkgs; [
    btop
    fastfetch

    file
    jq
    ripgrep
    tealdeer
    timg
    tree

    ghq
    gwq
    nh

    zip
    unzip
    unrar
  ];

  programs.home-manager.enable = true;
}
