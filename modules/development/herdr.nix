{
  ...
}:
{
  programs.herdr = {
    enable = true;
    settings = {
      onboarding = false;

      theme = {
        name = "rose-pine";
        auto_switch = false;
      };

      ui = {
        agent_panel_sort = "spaces";
      };

      keys = {
        open_worktree = "prefix+shift+o";
      };

      experimental = {
        pane_history = false;
      };
    };
  };
}
