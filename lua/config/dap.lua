local dap = require("dap")

-- Python
-- more options, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings
-- dap.configurations.python = {}

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
