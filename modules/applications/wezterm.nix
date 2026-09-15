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
        font = wezterm.font 'JetBrains Mono',
        font_rules = {
          {
            intensity = 'Bold',
            italic = false,
            font = wezterm.font('JetBrains Mono', { weight = 'DemiBold' }),
          },
          {
            intensity = 'Bold',
            italic = true,
            font = wezterm.font('JetBrains Mono', { weight = 'DemiBold', style = 'Italic' }),
          },
          {
            intensity = 'Half',
            italic = false,
            font = wezterm.font('JetBrains Mono', { weight = 'ExtraLight' }),
          },
          {
            intensity = 'Half',
            italic = true,
            font = wezterm.font('JetBrains Mono', { weight = 'ExtraLight', style = 'Italic' }),
          },
        },
        keys = {
          {
            key = 'Enter',
            mods = 'ALT',
            action = wezterm.action.DisableDefaultAssignment,
          },
          {
            key = 'Tab',
            mods = 'CTRL',
            action = wezterm.action.DisableDefaultAssignment,
          },
          {
            key = 'Tab',
            mods = 'CTRL|SHIFT',
            action = wezterm.action.DisableDefaultAssignment,
          },
          {
            key = 't',
            mods = 'CTRL|SHIFT',
            action = wezterm.action.DisableDefaultAssignment,
          },
          {
            key = 't',
            mods = 'SUPER',
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
