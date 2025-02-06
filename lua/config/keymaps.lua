-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Basic commands
vim.keymap.set("n", "U", "<C-r>", { noremap = true })

-- Trouble
-- vim.keymap.set("n", "<leader>s", "<cmd>Trouble symbols toggle focus=True<CR>", { silent = true, noremap = true, desc = "sybmols" })
vim.keymap.set(
  "n",
  "<leader>k",
  "<cmd>lua vim.diagnostic.open_float()<CR>",
  { silent = true, noremap = true, desc = "line diagnostics" }
)
-- vim.keymap.set("n", "<leader>D", "<cmd>Trouble diagnostics toggle focus=True<CR>", { silent = true, noremap = true, desc = "file diagnostics" })
-- vim.keymap.del("n", "<leader>fr")
vim.keymap.set(
  "n",
  "<leader>cs",
  '<cmd>lua require("fzf-lua").lsp_references()<CR>',
  { silent = true, remap = true, desc = "references" }
)
vim.keymap.set("n", "<leader>cS", "<cmd>Trouble symbols toggle<CR>", { silent = true, remap = true, desc = "symbols" })

-- keymap to copy line number and file path
vim.keymap.set(
  "n",
  "<leader>cp",
  ':let @+ = expand("%") . ":" . line(".")<CR>',
  { noremap = true, silent = true, desc = "copy line number" }
)

-- Remove keybindings
vim.keymap.del({ "n", "v", "i" }, "<M-j>")
vim.keymap.del({ "n", "v", "i" }, "<M-k>")

-- debugging
-- vim.keymap.set(
--   "n",
--   "<leader>dE",
--   "<cmd>lua require('dap').set_exception_breakpoints()<CR>",
--   { desc = "break on exception" }
-- )
