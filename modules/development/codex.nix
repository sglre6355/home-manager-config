{
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
}
