{
  llmAgentsPkgs,
  pkgs,
  ...
}:
let
  notificationHooks =
    if pkgs.stdenv.isDarwin then
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
in
{
  programs.claude-code = {
    enable = true;
    package = llmAgentsPkgs.claude-code;
    settings = {
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
  };
}
