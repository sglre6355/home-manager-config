{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "sglre6355";
  home.homeDirectory = "/home/sglre6355";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "26.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    bat
    btop
    claude-code
    codex
    file
    gcc
    tealdeer
    tree
    unzip
    wl-clipboard
    zip

    # Fonts
    nerd-fonts.fira-code
    nerd-fonts.fira-mono
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
  ];

  fonts.fontconfig.enable = true;

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/sglre6355/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "nvim";
  };

  home.shellAliases = {
    cat = "bat -pP";
    veracrypt = "veracrypt -t";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = lib.mkMerge [
      (fromTOML (builtins.readFile "${pkgs.starship}/share/starship/presets/bracketed-segments.toml"))
    ];
  };

  programs.nixvim = {
    enable = true;

    extraPackages = with pkgs; [
      hadolint
      commitlint
      golangci-lint
      markdownlint-cli2
      nix
      python313Packages.flake8
      actionlint
    ];

    opts = {
      mouse = "a";

      swapfile = false;
      backup = false;
      hidden = true;

      number = true;
      signcolumn = "yes";

      ignorecase = true;
      smartcase = true;
      wrapscan = true;

      tabstop = 4;
      shiftwidth = 4;
      expandtab = true;
      smartindent = false;
    };

    diagnostic.settings = {
      virtual_text = true;
      signs = true;
      underline = true;
      update_in_insert = true;
    };

    keymaps = [
      {
        mode = "n";
        action = '':lua require("lint").try_lint()<CR>'';
        key = "<A-l>";
        options.silent = true;
      }
      {
        mode = "n";
        action = '':lua require("conform").format()<CR>'';
        key = "<A-f>";
        options.silent = true;
      }
      {
        mode = "n";
        action = ":Telescope find_files<CR>";
        key = "<C-f>";
        options.silent = true;
      }
    ];

    colorschemes.kanagawa.enable = true;

    plugins = {
      blink-cmp = {
        enable = true;
        settings = {
          keymap = {
            preset = "enter";
            "<CR>" = [
              "accept"
              "fallback"
            ];
            "<Tab>" = [
              "select_next"
              "fallback"
            ];
            "<S-Tab>" = [
              "select_prev"
              "fallback"
            ];
          };
          appearance.nerd_font_variant = "mono";
          completion = {
            documentation = {
              auto_show = true;
              auto_show_delay_ms = 0;
            };
            list.selection.preselect = true;
          };
          sources = {
            default = [
              "lsp"
              "path"
              "snippets"
              "buffer"
            ];
          };
          snippets = {
            preset = "luasnip";
          };
          signature.enabled = true;
        };
      };
      conform-nvim = {
        enable = true;
        autoInstall.enable = true;
        settings = {
          notify_on_error = true;
          formatters_by_ft = {
            go = [ "golangci-lint" ];
            html = [ "prettierd" ];
            javascript = [ "prettierd" ];
            lua = [ "stylua" ];
            markdown = [ "markdownlint" ];
            nix = [ "nixfmt" ];
            protobuf = [ "buf" ];
            python = [
              "isort"
              "black"
            ];
            # TODO: configure nightly options
            rust = [ "rustfmt" ];
            sql = [ "sql_formatter" ];
            typst = [ "typstyle" ];
            xml = [ "xmlformatter" ];
            yaml = [ "yamlfmt" ];
          };
        };
      };
      fidget.enable = true;
      indent-blankline.enable = true;
      lsp = {
        enable = true;
        autoload = true;
        inlayHints = true;
        servers = {
          gopls.enable = true;
          nixd.enable = true;
          # TODO: switch to lspmux
          rust_analyzer = {
            enable = true;
            installCargo = false;
            installRustc = false;
          };
        };
      };
      lint = {
        enable = true;
        lintersByFt = {
          dockerfile = [ "hadolint" ];
          gitcommit = [ "commitlint" ];
          go = [ "golangcilint" ];
          markdown = [ "markdownlint-cli2" ];
          nix = [ "nix" ];
          python = [ "flake8" ];
          yaml = [ "actionlint" ];
        };
      };
      lualine.enable = true;
      luasnip.enable = true;
      notify.enable = true;
      telescope.enable = true;
      treesitter = {
        enable = true;
        settings = {
          highlight.enable = true;
          autotag.enable = true;
          indent.enable = true;
        };
      };
      todo-comments = {
        enable = true;
        settings = {
          signs = true;
        };
      };
      web-devicons.enable = true;
    };
  };

  programs.git = {
    enable = true;
    includes = [
      {
        contents = {
          user = {
            email = "sglre6355@gmail.com";
            name = "sglre6355";
          };
          commit = {
            gpgSign = true;
          };
        };
      }
    ];
  };

  services.gpg-agent = {
    enable = true;
    enableZshIntegration = true;
    pinentry.package = pkgs.pinentry-curses;
  };

  xdg.userDirs = {
    enable = true;
    createDirectories = false;
    documents = "${config.home.homeDirectory}/documents";
    download = "${config.home.homeDirectory}/download";
  };

  gtk = {
    enable = true;
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
  };

  qt.enable = true;

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };
  };

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      addons = with pkgs; [
        fcitx5-mozc-ut
        fcitx5-gtk
      ];
      settings = {
        globalOptions = {
          "Hotkey/TriggerKeys" = {
            "0" = "Alt+Shift_L";
          };
        };
        inputMethod = {
          GroupOrder."0" = "Default";
          "Groups/0" = {
            Name = "Default";
            "Default Layout" = "us";
            DefaultIM = "mozc";
          };
          "Groups/0/Items/0".Name = "keyboard-us";
          "Groups/0/Items/1".Name = "mozc";
        };
      };
      waylandFrontend = true;
      ignoreUserConfig = true;
    };
  };

  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    config = rec {
      modifier = "Mod4";
      terminal = "wezterm";
      menu = "wofi --show drun -D key_expand=Tab";
      output = {
        "*" = {
          bg = "#4e4e4e solid_color";
        };
      };
      bars = [
        {
          position = "top";
          statusCommand = "${pkgs.i3status}/bin/i3status";
          colors = {
            background = "#323232";
            statusline = "#ffffff";
            inactiveWorkspace = {
              border = "#323232";
              background = "#323232";
              text = "#5c5c5c";
            };
          };
        }
      ];
      focus.wrapping = "workspace";
      workspaceLayout = "tabbed";
      keybindings = lib.mkOptionDefault {
        "${modifier}+Tab" = "focus next";
        "${modifier}+Shift+Tab" = "focus prev";

        "Alt+Tab" = "workspace next";
        "Alt+Shift+Tab" = "workspace prev";

        "Alt+Control+Tab" = "focus output right";
        "Alt+Control+Shift+Tab" = "focus output left";

        "${modifier}+Control+Shift+Left" = "move workspace to output left";
        "${modifier}+Control+Shift+Down" = "move workspace to output down";
        "${modifier}+Control+Shift+Up" = "move workspace to output up";
        "${modifier}+Control+Shift+Right" = "move workspace to output right";

        "--locked XF86AudioRaiseVolume" =
          "exec ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +5%";
        "--locked XF86AudioLowerVolume" =
          "exec ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ -5%";
        "--locked XF86AudioMute" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle";
        "--locked XF86AudioMicMute" =
          "exec ${pkgs.pulseaudio}/bin/pactl set-source-mute @DEFAULT_SOURCE@ toggle";

        "--locked XF86MonBrightnessUp" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set 10%+";
        "--locked XF86MonBrightnessDown" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set 10%-";
        "--locked XF86MonBrightnessUp+Shift" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set 5%+";
        "--locked XF86MonBrightnessDown+Shift" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set 5%-";

        # Snipping tool
        "${modifier}+Shift+s" =
          "exec ${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp)\" - | ${pkgs.wl-clipboard}/bin/wl-copy";

        # Lock screen
        "${modifier}+l" = "exec ${pkgs.swaylock}/bin/swaylock -f";
        # Lock screen and suspend
        "${modifier}+Shift+l" =
          "exec ${pkgs.systemd}/bin/systemctl suspend; ${pkgs.swaylock}/bin/swaylock -f";
      };
    };
  };

  programs.wofi.enable = true;

  programs.swaylock = {
    enable = true;
    settings = {
      color = "4e4e4e";
      show-failed-attempts = true;
    };
  };

  services.swayidle = {
    enable = true;
    events = {
      after-resume = ''${pkgs.sway}/bin/swaymsg "output * power on"'';
      before-sleep = "${pkgs.swaylock}/bin/swaylock -f";
    };
    timeouts = [
      {
        timeout = 180;
        command = "${pkgs.swaylock}/bin/swaylock -f";
      }
      {
        timeout = 300;
        command = ''${pkgs.sway}/bin/swaymsg "output * power off"'';
      }
      {
        timeout = 900;
        command = "${pkgs.systemd}/bin/systemctl suspend";
      }
    ];
  };

  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
    extraConfig = ''
      local wezterm = require 'wezterm'
      return {
        automatically_reload_config = true,
        enable_tab_bar = false,
        keys = {
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

  programs.firefox = {
    enable = true;
    policies = {
      AutofillAddressEnabled = false;
      AutofillCreditCardEnabled = false;
      DisableTelemetry = true;
      DNSOverHTTPS = {
        Enabled = true;
        ProviderURL = "https://mozilla.cloudflare-dns.com/dns-query";
        Fallback = false;
      };
      EnableTrackingProtection = {
        Value = true;
        Category = "strict";
      };
      EncryptedMediaExtensions = {
        Enabled = true;
      };
      FirefoxHome = {
        Search = false;
        TopSites = false;
        SponsoredTopSites = false;
        Highlights = false;
        Pocket = false;
        SponsoredPocket = false;
        Snippets = false;
      };
      Homepage = {
        StartPage = "none";
      };
      HttpsOnlyMode = "enabled";
      NewTabPage = false;
      OfferToSaveLogins = false;
      SanitizeOnShutdown = {
        FormData = true;
      };
      SearchSuggestEnabled = true;
      UserMessaging = {
        FeatureRecommendations = false;
        SkipOnboarding = true;
      };
    };
    profiles = {
      default = {
        isDefault = true;
        settings = {
          "browser.toolbars.bookmarks.visibility" = "never";
          "browser.urlbar.suggest.bookmark" = false;
          "browser.urlbar.suggest.engines" = false;
          "browser.urlbar.suggest.openpage" = false;
          "browser.urlbar.suggest.quickactions" = false;
          "browser.urlbar.suggest.quicksuggest.all" = false;
          "browser.urlbar.suggest.topsites" = false;
          "browser.urlbar.suggest.trending" = false;
          "privacy.globalprivacycontrol.enabled" = true;
          "ui.key.menuAccessKeyFocuses" = false;
        };
        extensions = {
          packages = with pkgs.nur.repos.rycee.firefox-addons; [
            bitwarden
            raindropio
          ];
        };
      };
    };
  };

  programs.discord.enable = true;
}
