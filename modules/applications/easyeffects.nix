{
  config,
  pkgs,
  ...
}:
{
  services.easyeffects = {
    enable = true;
    preset = "noise-reduction";
    extraPresets = {
      noise-reduction = {
        input = {
          blocklist = [ ];
          plugins_order = [
            "rnnoise#0"
            "deepfilternet#0"
          ];
          "rnnoise#0" = {
            bypass = false;
            enable-vad = false;
            input-gain = 0.0;
            model-name = "";
            output-gain = 0.0;
            release = 20.0;
            use-standard-model = true;
            vad-thres = 30.0;
            wet = 0.0;
          };
          "deepfilternet#0" = {
            attenuation-limit = 100.0;
            bypass = false;
            input-gain = 0.0;
            max-df-processing-threshold = 20.0;
            max-erb-processing-threshold = 30.0;
            min-processing-buffer = 0;
            min-processing-threshold = 5.0;
            output-gain = 0.0;
            post-filter-beta = 0.02;
          };
        };
      };
    };
  };

  systemd.user.services.easyeffects.Service.ExecStartPost = [
    "${pkgs.coreutils}/bin/sleep 5"
    "${config.services.easyeffects.package}/bin/easyeffects --load-preset ${config.services.easyeffects.preset}"
  ];
}
