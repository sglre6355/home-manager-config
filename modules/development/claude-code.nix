{
  llmAgentsPkgs,
  pkgs,
  ...
}:
let
  notificationHooks =
    if pkgs.stdenv.hostPlatform.isDarwin then
      [
        {
          type = "command";
          command = ''osascript -e 'display notification "Claude Code needs your attention" with title "Claude Code" sound name "Funk"' '';
        }
      ]
    else
      [
        {
          type = "command";
          command = "${pkgs.libnotify}/bin/notify-send 'Claude Code' 'Claude Code needs your attention'";
        }
        {
          type = "command";
          command = "${pkgs.pipewire}/bin/pw-play --volume 10 ${pkgs.sound-theme-freedesktop}/share/sounds/freedesktop/stereo/window-attention.oga";
        }
      ];

  # Injected via `--settings` so that ~/.claude/settings.json stays a regular
  # file writable by Claude Code itself (/model, /config). CLI-flag settings
  # merge on top of the user scope instead of replacing it.
  declarativeSettings = {
    hooks = {
      Notification = [
        {
          matcher = "";
          hooks = notificationHooks;
        }
      ];
    };
    statusLine = {
      type = "command";
      command = "${pkgs.ccusage}/bin/ccusage statusline";
      padding = 0;
    };
    includeCoAuthoredBy = false;
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
