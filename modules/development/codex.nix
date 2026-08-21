{
  llmAgentsPkgs,
  ...
}:
{
  programs.codex = {
    enable = true;
    package = llmAgentsPkgs.codex;
  };
}
