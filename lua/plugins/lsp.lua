return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        virtual_text = false,
      },
      servers = {
        -- pyright will be automatically installed with mason and loaded with lspconfig
        pyright = {
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
        ruff = {
          init_options = {
            settings = {
              config = "pyproject.toml",
              configurationPreference = "filesystemFirst",
              -- lineLength = 100,
              -- Ruff language server settings go here
            },
          },
        },
        -- pylsp = {
        --   plugins = {
        --     rope_completion = {
        --       enabled = true,
        --     },
        --     rope_autoimport = {
        --       enabled = true,
        --     },
        --   },
        -- },
      },
    },
  },
  -- {
  --   "stevearc/conform.nvim",
  --   opts = {
  --     formatters_by_ft = {
  --       python = { "ruff" },
  --     },
  --   },
  -- },
}
