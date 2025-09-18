return {
  -- disable any other plugin's override of vim.ui.select
  {
    "stevearc/dressing.nvim",
    enabled = false,
  },
  {
    "folke/noice.nvim",
    opts = {
      lsp = {
        -- disable Noice’s override of vim.ui.select
        override = {
          ["vim.ui.select"] = false,
        },
      },
    },
  },
}
