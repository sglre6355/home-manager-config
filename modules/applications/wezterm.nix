{
  ...
}:
{
  programs.wezterm = {
    enable = true;
    extraConfig = /* lua */ ''
      local wezterm = require 'wezterm'
      return {
        automatically_reload_config = true,
        enable_tab_bar = false,
        enable_kitty_keyboard = true,
        keys = {
          {
            key = 'Enter',
            mods = 'ALT',
            action = wezterm.action.DisableDefaultAssignment,
          },
          {
            key = 'LeftArrow',
            mods = 'CTRL',
            action = wezterm.action.SendString '\x1bb',
          },
          {
            key = 'RightArrow',
            mods = 'CTRL',
            action = wezterm.action.SendString '\x1bf',
          },
        },
      }
    '';
  };
}
