{
  pkgs,
  ...
}:
{
  programs.nixvim =
    { lib, ... }:
    {
      enable = true;

      nixpkgs.config.allowUnfree = true;

      dependencies = {
        go.packageFallback = true;
      };

      extraPackages = with pkgs; [
        hadolint
        commitlint
        golangci-lint
        rumdl
        nix
        python313Packages.flake8
      ];

      files = {
        "ftplugin/nix.lua" = {
          opts = {
            expandtab = true;
            shiftwidth = 2;
            tabstop = 2;
          };
        };
      };

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

        foldenable = true;
        foldcolumn = "1";
        foldlevel = 99;
        foldlevelstart = 99;
        fillchars = "eob: ,fold: ,foldopen:,foldsep: ,foldinner: ,foldclose:";
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
            formatters = {
              clang-format = {
                append_args = [
                  "--style={BasedOnStyle: LLVM, IndentWidth: 4}"
                ];
              };
              typstyle = {
                append_args = [
                  "--line-width"
                  "120"
                  "--wrap-text"
                ];
              };
            };
            formatters_by_ft = {
              cpp = [ "clang-format" ];
              cuda = [ "clang-format" ];
              go = [ "golangci-lint" ];
              html = [ "prettierd" ];
              javascript = [ "prettierd" ];
              lua = [ "stylua" ];
              markdown = [ "rumdl" ];
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
        diffview.enable = true;
        fidget.enable = true;
        git-conflict.enable = true;
        gitsigns.enable = true;
        indent-blankline.enable = true;
        lsp = {
          enable = true;
          autoload = true;
          inlayHints = false;
          onAttach = /* lua */ ''
            vim.api.nvim_set_keymap("n", "<A-CR>", ":lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })
            vim.api.nvim_set_keymap("n", "<A-S-CR>", ":lua vim.lsp.buf.declaration()<CR>", { noremap = true, silent = true })
            vim.api.nvim_set_keymap("n", "<A-BS>", "<C-t>", { noremap = true, silent = true })
          '';
          servers = {
            clangd.enable = true;
            gopls = {
              enable = true;
              packageFallback = true;
            };
            nixd.enable = true;
            rust_analyzer = {
              enable = true;
              installCargo = true;
              installRustc = true;
              extraOptions = {
                cmd = lib.nixvim.mkRaw ''
                  vim.lsp.rpc.connect("127.0.0.1", 27631)
                '';
                settings.rust-analyzer = {
                  lspMux = {
                    version = "1";
                    method = "connect";
                    server = "rust-analyzer";
                  };
                };
              };
            };
            tinymist.enable = true;
            ty.enable = true;
          };
        };
        lint = {
          enable = true;
          linters = {
            flake8.args = [
              "--format=%(path)s:%(row)d:%(col)d:%(code)s:%(text)s"
              "--no-show-source"
              "--stdin-display-name"
              "--max-line-length=120"
              (lib.nixvim.mkRaw "function() return vim.api.nvim_buf_get_name(0) end")
              "-"
            ];
          };
          lintersByFt = {
            dockerfile = [ "hadolint" ];
            gitcommit = [ "commitlint" ];
            go = [ "golangcilint" ];
            markdown = [ "rumdl" ];
            nix = [ "nix" ];
            python = [ "flake8" ];
          };
        };
        lualine.enable = true;
        luasnip.enable = true;
        nvim-ufo = {
          enable = true;
          settings = {
            provider_selector = lib.nixvim.mkRaw ''
              function(bufnr, filetype, buftype)
                return {"treesitter", "indent"}
              end
            '';
          };
        };
        notify.enable = true;
        telescope.enable = true;
        treesitter = {
          enable = true;
          highlight.enable = true;
          indent.enable = true;
          folding.enable = true;
          settings = {
            autotag.enable = true;
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

  systemd.user.services.lspmux = {
    Unit = {
      Description = "Language server multiplexer server";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.lspmux}/bin/lspmux server";
      Environment = [
        "PATH=${pkgs.gcc}/bin:${pkgs.cargo}/bin:${pkgs.rustc}/bin:${pkgs.rust-analyzer}/bin"
        "RUST_SRC_PATH=${pkgs.rustPlatform.rustLibSrc}"
      ];
    };
  };
}
