return {
  -- Note: Mason, mason-lspconfig, and mason-nvim-dap are handled by LazyVim defaults.
  -- If you need to disable them or customize further, uncomment and configure below:
  -- { "williamboman/mason.nvim", enabled = false },
  -- { "williamboman/mason-lspconfig.nvim", enabled = false },
  -- { "williamboman/mason-nvim-dap.nvim", enabled = false },

  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
      diagnostics = {
        virtual_text = false,
      },
      servers = {
        pyright = {
          enabled = false,
        },
        -- basedpyright is a fork of pyright with better type inference and features
        basedpyright = {
          enabled = true,
          settings = {
            basedpyright = {
              analysis = {
                typeCheckingMode = "standard",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "openFilesOnly",
              },
            },
          },
        },
        gleam = {
          enabled = true,
        },
        -- ruby_lsp = {
        --   init_options = {
        --     formatter = "standard", -- Or "rubocop", etc.
        --     linters = { "standard" }, -- Or { "rubocop", "reek" }, etc.
        --     addonSettings = {
        --       ["Ruby LSP Rails"] = {
        --         enablePendingMigrationsPrompt = false, -- Example: disable Rails-specific prompt
        --       },
        --     },
        --   },
        -- },
        -- ty type checker
        ty = {
          enabled = false,
          settings = {
            ty = {
              completions = {
                autoImport = true,
              },
              inlayHints = {
                variableTypes = true,
                callArgumentNames = true,
              },
            },
          },
        },
        -- ruff linter / formater
        ruff = {
          enabled = true,
          -- mason = false,
          init_options = {
            settings = {
              -- config = "pyproject.toml",
              configurationPreference = "filesystemFirst",
              -- lineLength = 128,
              logLevel = "warn",
              fixAll = true,
              showSyntaxErrors = true,
              lint = {
                enabled = true,
                preview = true,
              },
              codeAction = {
                disableRuleComment = {
                  enable = true,
                },
                fixViolation = {
                  enable = true,
                },
              },
            },
          },
        },
        pylsp = {
          enabled = false,
          --pylsp settings
          -- cmd = { "pylsp", "--tcp", "--host=127.0.0.1", "--port=0" },
          -- Add Pylint configuration here if needed
          settings = {
            pylsp = {
              plugins = {
                pylint = {
                  enabled = false,
                  -- executable = "~/.local/bin/pylint", -- Adjust path if necessary
                },
                rope_autoimport = { enabled = true },
                -- pylsp_rope = { enabled = true },
              },
            },
          },
        },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "ruff" },
        -- python = { "black" },
      },
    },
  },
}
