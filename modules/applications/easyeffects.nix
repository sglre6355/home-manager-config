{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf pkgs.stdenv.hostPlatform.isLinux {
    services.easyeffects = {
      enable = true;
      preset = "default";
      extraPresets = {
        default = {
          input = {
            blocklist = [ ];
            plugins_order = [
              "autogain#0"
              "rnnoise#0"
              "deepfilternet#0"
            ];
            "autogain#0" = { };
            "rnnoise#0" = { };
            "deepfilternet#0" = { };
          };
        };
      };
    };

    systemd.user.services.easyeffects.Service.ExecStartPost = [
      "${pkgs.coreutils}/bin/sleep 5"
      "${config.services.easyeffects.package}/bin/easyeffects --load-preset ${config.services.easyeffects.preset}"
    ];
  };
}
