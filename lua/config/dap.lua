local dap = require("dap")

-- Python
-- more options, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings
-- dap.configurations.python = {}
-- DAP config

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
  module = function()
    local module_name = vim.fn.input("Module: ")
    return module_name
  end,
  args = function()
    local args_string = vim.fn.input("Arguments: ")
    local utils = require("dap.utils")
    if utils.splitstr and vim.fn.has("nvim-0.10") == 1 then
      return utils.splitstr(args_string)
    end
    return vim.split(args_string, " +")
  end,
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
  type = "debugpy",
  request = "launch",
  args = { "main:app" },
  module = "uvicorn",
})
table.insert(dap.configurations.python, {
  name = "django command",
  type = "python",
  request = "launch",
  program = "${workspaceFolder}/manage.py",
  args = function()
    local args_string = vim.fn.input("Arguments: ")
    local utils = require("dap.utils")
    if utils.splitstr and vim.fn.has("nvim-0.10") == 1 then
      return utils.splitstr(args_string)
    end
    return vim.split(args_string, " +")
  end,
  justMyCode = false,
  cwd = "${workspaceFolder}",
})
table.insert(dap.configurations.python, {
  name = "pytest",
  type = "python",
  request = "launch",
  module = "pytest",
  args = function()
    local args_string = vim.fn.input("Arguments: ")
    local utils = require("dap.utils")
    if utils.splitstr and vim.fn.has("nvim-0.10") == 1 then
      return utils.splitstr(args_string)
    end
    return vim.split(args_string, " +")
  end,
  justMyCode = false,
  cwd = "${workspaceFolder}",
})
table.insert(dap.configurations.python, {
  name = "celery",
  type = "debugpy",
  request = "launch",
  module = "celery",
  args = function()
    local args_string = vim.fn.input("Arguments: ")
    local utils = require("dap.utils")
    if utils.splitstr and vim.fn.has("nvim-0.10") == 1 then
      return utils.splitstr(args_string)
    end
    return vim.split(args_string, " +")
  end,
  justMyCode = false,
  cwd = "${workspaceFolder}",
})
