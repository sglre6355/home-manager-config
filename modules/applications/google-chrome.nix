{
  lib,
  pkgs,
  ...
}:
{
  programs.google-chrome.enable = true;

  targets.darwin.defaults = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin {
    "com.google.Chrome" = {
      # Keys must match Chrome's menu item titles exactly (including "…").
      # Modifiers: ^ = Ctrl, $ = Shift, ~ = Option, @ = Cmd.
      NSUserKeyEquivalents = {
        # File
        "New Tab" = "^t";
        "New Window" = "^n";
        "New Incognito Window" = "^$n";
        "Reopen Closed Tab" = "^$t";
        "Open File…" = "^o";
        "Open Location…" = "^l";
        "Close Window" = "^$w";
        "Close Tab" = "^w";
        "Save Page As…" = "^s";
        "Print…" = "^p";

        # Edit
        # Cut/Copy/Paste/Paste and Match Style/Select All/Undo/Redo are handled
        # system-wide via Karabiner (see karabiner.nix), not here.
        "Find…" = "^f";
        "Find Next" = "^g";
        "Find Previous" = "^$g";

        # View
        "Reload This Page" = "^r";
        "Force Reload This Page" = "^$r";
        "Actual Size" = "^0";
        "Zoom In" = "^+";
        "Zoom Out" = "^-";
        "View Source" = "^u";
        "Developer Tools" = "^$i";
        "JavaScript Console" = "^$j";

        # History
        "Show Full History" = "^h";

        # Bookmarks
        "Bookmark This Tab…" = "^d";
        "Bookmark All Tabs…" = "^$d";
        "Show Bookmarks Bar" = "^$b";
        "Bookmark Manager" = "^$o";

        # Window
        "Downloads" = "^j";
      };
    };
  };
}
