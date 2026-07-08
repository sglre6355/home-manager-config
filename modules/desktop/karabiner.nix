{
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf pkgs.stdenv.isDarwin {
    home.file = {
      ".config/karabiner/karabiner.json" = {
        force = true;
        text = builtins.toJSON {
          profiles = [
            {
              name = "Default";
              selected = true;
              virtual_hid_keyboard = {
                keyboard_type_v2 = "ansi";
              };
              complex_modifications = {
                rules = [
                  {
                    description = "Remap Cmd+Tab to F18 for AeroSpace";
                    manipulators = [
                      {
                        type = "basic";
                        from = {
                          key_code = "tab";
                          modifiers = {
                            mandatory = [ "command" ];
                            optional = [ "caps_lock" ];
                          };
                        };
                        to = [
                          { key_code = "f18"; }
                        ];
                      }
                    ];
                  }
                  {
                    description = "Remap Cmd+Shift+Tab to F19 for AeroSpace";
                    manipulators = [
                      {
                        type = "basic";
                        from = {
                          key_code = "tab";
                          modifiers = {
                            mandatory = [ "command" "shift" ];
                            optional = [ "caps_lock" ];
                          };
                        };
                        to = [
                          { key_code = "f19"; }
                        ];
                      }
                    ];
                  }
                ];
              };
            }
          ];
        };
      };
    };
  };
}
