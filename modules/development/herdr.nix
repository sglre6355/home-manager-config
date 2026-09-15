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
        next_workspace = "ctrl+tab";
        previous_workspace = "ctrl+shift+tab";
      };

      experimental = {
        pane_history = false;
      };
    };
  };
}
