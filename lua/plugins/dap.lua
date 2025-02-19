return {
  {
    "mfussenegger/nvim-dap",
    opts = {},
  },
  {
    "lucaSartore/nvim-dap-exception-breakpoints",
    dependencies = { "mfussenegger/nvim-dap" },

    config = function()
      local set_exception_breakpoints = require("nvim-dap-exception-breakpoints")

      vim.api.nvim_set_keymap(
        "n",
        "<leader>dE",
        "",
        { desc = "condition breakpoints", callback = set_exception_breakpoints }
      )
    end,
  },
}
