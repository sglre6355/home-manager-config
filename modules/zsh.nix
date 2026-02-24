{
  config,
  lib,
  ...
}:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    initContent = ''
      autoload -Uz select-word-style
      select-word-style bash
    '';
    syntaxHighlighting.enable = true;
  };

  programs = {
    wezterm.enableZshIntegration = true;
    starship.enableZshIntegration = true;
    direnv.enableZshIntegration = true;
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
    ];
  };
}
