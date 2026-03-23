local dap = require("dap")

-- Python
-- more options, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings
-- dap.configurations.python = {}
-- DAP config

vim.api.nvim_set_hl(0, "DapStoppedLine", { bg = "#214067" })
vim.api.nvim_set_hl(0, "DapStoppedSign", { fg = "#ffbe6f" }) -- Custom colors
vim.api.nvim_set_hl(0, "SignColumn", { fg = "#9AA6CB" }) -- Bright red for breakpoints
--
vim.fn.sign_define("DapStopped", {
  text = "",
  texthl = "DapStoppedSign", -- Color of the icon
  linehl = "DapStoppedLine", -- Highlight the entire line
  numhl = "", -- Highlight the line number
})

-- Helper function to parse command-line arguments
local function get_args()
  local args_string = vim.fn.input("Arguments: ")
  local utils = require("dap.utils")
  if utils.splitstr and vim.fn.has("nvim-0.10") == 1 then
    return utils.splitstr(args_string)
  end
  return vim.split(args_string, " +")
end

-- Helper function to get module name
local function get_module()
  return vim.fn.input("Module: ")
end

table.insert(dap.configurations.python, {
  -- Configuration for launching a file
  type = "python",
  request = "launch",
  name = "Launch Python File",
  program = "${file}", -- Debug the current file
  justMyCode = false, -- <--- Set justMyCode to false here
})
table.insert(dap.configurations.python, {
  name = "python module: args",
  type = "python",
  request = "launch",
  module = get_module,
  args = get_args,
  justMyCode = false,
  cwd = "${workspaceFolder}",
})
table.insert(dap.configurations.python, {
  name = "Django",
  type = "python",
  request = "launch",
  program = "${workspaceFolder}/manage.py",
  args = { "runserver" },
  justMyCode = false,
  cwd = "${workspaceFolder}",
})
table.insert(dap.configurations.python, {
  name = "FastAPI",
  type = "python",
  request = "launch",
  args = { "main:app" },
  module = "uvicorn",
  justMyCode = false,
})
table.insert(dap.configurations.python, {
  name = "django command",
  type = "python",
  request = "launch",
  program = "${workspaceFolder}/manage.py",
  args = get_args,
  justMyCode = false,
  cwd = "${workspaceFolder}",
})
table.insert(dap.configurations.python, {
  name = "pytest",
  type = "python",
  request = "launch",
  module = "pytest",
  args = get_args,
  justMyCode = false,
  cwd = "${workspaceFolder}",
})
table.insert(dap.configurations.python, {
  name = "celery",
  type = "python",
  request = "launch",
  module = "celery",
  args = get_args,
  justMyCode = false,
  cwd = "${workspaceFolder}",
})
