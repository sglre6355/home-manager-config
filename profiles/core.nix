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
    ../modules/commands/zellij.nix
    ../modules/commands/zoxide.nix

    ../modules/development/git.nix
    ../modules/development/gh.nix
    ../modules/development/herdr.nix

    ../modules/applications/firefox.nix
    ../modules/applications/junction.nix
    ../modules/applications/wezterm.nix
  ];

  home.sessionPath = [ "${config.home.homeDirectory}/.local/bin" ];

  programs.zsh.initContent = /* zsh */ ''
    # cd into a ghq-managed repository
    cdr() {
      local repo
      repo=$(ghq list --full-path | fzf) && cd "$repo"
    }

    # cd into a git-wt-managed worktree
    cdw() {
      local worktree
      worktree=$(git-wt --json | ${pkgs.jq}/bin/jq -r '.[].path' | fzf) && cd "$worktree"
    }

    # enable `git wt` directory switching
    eval "$(git-wt --init zsh)"
  '';

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
    git-wt
    nh

    zip
    unzip
    unrar
  ];

  programs.home-manager.enable = true;
}
