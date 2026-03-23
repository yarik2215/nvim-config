-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- DAP config is now lazy-loaded via lua/plugins/dap.lua

vim.o.exrc = true
vim.o.secure = true
