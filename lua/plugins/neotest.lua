return {
  {
    "nvim-neotest/neotest",
    dependencies = { "nvim-neotest/nvim-nio", "nvim-treesitter/nvim-treesitter" },
    opts = {
      -- floatin = {
      --   options = {
      --     focus = true,
      --   },
      -- },
      -- status = {
      --   virtual_text = false,
      -- },
      adapters = {
        ["neotest-python"] = {
          -- args = { "--log-level", "DEBUG", "-s" },
          dap = {
            justMyCode = false,
            -- redirectOutput = false,
            -- console = "integratedTerminal",
            -- pythonPath = function()
            --   return require("venv-selector").get_active_path()
            -- end,
          },
          pytest_discover_instances = true,
        },
      },
    },
  },
}
