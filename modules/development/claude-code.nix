{
  masterPkgs,
  pkgs,
  ...
}:
{
  programs.claude-code = {
    enable = true;
    package = masterPkgs.claude-code;
    settings = {
      hooks = {
        Notification = [
          {
            matcher = "";
            hooks = [
              {
                type = "command";
                command = "${pkgs.libnotify}/bin/notify-send 'Claude Code' 'Claude Code needs your attention'";
              }
              {
                type = "command";
                command = "${pkgs.pipewire}/bin/pw-play --volume 10 ${pkgs.sound-theme-freedesktop}/share/sounds/freedesktop/stereo/window-attention.oga";
              }
            ];
          }
        ];
      };
      includeCoAuthoredBy = false;
    };
  };
}
