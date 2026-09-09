{
  llmAgentsPkgs,
  pkgs,
  ...
}:
let
  # Injected via `--settings` so that ~/.claude/settings.json stays a regular
  # file writable by Claude Code itself (/model, /config). CLI-flag settings
  # merge on top of the user scope instead of replacing it.
  declarativeSettings = {
    statusLine = {
      type = "command";
      command = "${llmAgentsPkgs.ccstatusline}/bin/ccstatusline";
      padding = 0;
    };
    attribution = {
      commit = "";
      pr = "";
      sessionUrl = false;
    };
  };

  declarativeSettingsFile = pkgs.writeText "claude-code-declarative-settings.json" (
    builtins.toJSON declarativeSettings
  );

  wrappedClaudeCode = pkgs.symlinkJoin {
    name = "claude-code-wrapped";
    paths = [ llmAgentsPkgs.claude-code ];
    nativeBuildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/claude \
        --add-flags "--settings ${declarativeSettingsFile}"
    '';
  };
in
{
  programs.claude-code = {
    enable = true;
    package = wrappedClaudeCode;
    skills = {
      herdr = "${pkgs.herdr.src}/skills/herdr/SKILL.md";
    };
    # Do NOT set `settings` (or `marketplaces` / MCP server disabling) here:
    # any of them makes home-manager symlink ~/.claude/settings.json into the
    # store, which breaks /model and /config persistence.
  };
}
