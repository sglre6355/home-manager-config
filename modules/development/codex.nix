{
  config,
  llmAgentsPkgs,
  pkgs,
  ...
}:
{
  programs.codex = {
    enable = true;
    package = llmAgentsPkgs.codex;
    skills = {
      herdr = "${pkgs.herdr.src}/skills/herdr/SKILL.md";
    };
  };

  # `codex app-server daemon start` (and hence `codex remote-control`) refuses
  # to run unless it finds a "managed standalone" install at this fixed path.
  # Point it at the Nix-provided binary instead of running that installer.
  home.file.".codex/packages/standalone/current/codex".source =
    "${config.programs.codex.package}/bin/codex";
}
