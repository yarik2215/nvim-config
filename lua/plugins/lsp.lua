return {
  -- { "williamboman/mason.nvim", enabled = false, opts = { ensure_installed = {} } },
  -- { "williamboman/mason-nvim-dap.nvim", enabled = false },
  -- {
  --   "williamboman/mason-lspconfig.nvim",
  --   enabled = false,
  --   opts = {
  --     ensure_installed = {},
  --     automatic_installation = false, -- Disable auto setup of LSPs entirely
  --     handlers = {},
  --   },
  -- },
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
      diagnostics = {
        virtual_text = false,
      },
      servers = {
        -- pyright will be automatically installed with mason and loaded with lspconfig
        -- docs:
        pyright = {
          enabled = true,
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "standard",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                disableOrganizeImports = true,
                diagnosticMode = "openFilesOnly", -- Limit diagnostics to open files only (reducing noise)
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
          enabled = true,
          settings = {},
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
                  enabled = true,
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
