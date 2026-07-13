{
  config,
  lib,
  ...
}:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    history = {
      size = 10000000;
      ignoreAllDups = true;
    };
    shellAliases = {
      ls = "ls --color=auto";
    };
    initContent = /* zsh */ ''
      autoload -Uz select-word-style
      select-word-style bash

      bindkey '^[[Z' undo # Shift+Tab
      bindkey '^[`' push-line # Alt+`
    '';
    syntaxHighlighting.enable = true;
  };

  programs = {
    wezterm.enableZshIntegration = false;
    starship.enableZshIntegration = true;
    direnv.enableZshIntegration = true;
    fzf.enableZshIntegration = true;
    zoxide.enableZshIntegration = true;
  };
  services = {
    gpg-agent.enableZshIntegration = true;
  };

  programs.starship = {
    enable = true;
    settings = lib.mkMerge [
      (fromTOML (
        builtins.readFile "${config.programs.starship.package}/share/starship/presets/bracketed-segments.toml"
      ))
      {
        gcloud.disabled = true;
      }
    ];
  };
}
