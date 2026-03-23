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
  { silent = true, noremap = true, desc = "references" }
)
vim.keymap.set(
  "n",
  "<leader>cS",
  "<cmd>Trouble symbols toggle<CR>",
  { silent = true, noremap = true, desc = "symbols" }
)

-- keymap to copy line number and file path
vim.keymap.set(
  "n",
  "<leader>cp",
  ':let @+ = expand("%") . ":" . line(".")<CR>',
  { noremap = true, silent = true, desc = "copy line number" }
)

-- Git hunk navigation (like Helix ]g / [g)
vim.keymap.set("n", "]g", function() require("gitsigns").next_hunk() end, { desc = "next git hunk" })
vim.keymap.set("n", "[g", function() require("gitsigns").prev_hunk() end, { desc = "prev git hunk" })

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

local function get_full_symbol_path()
  -- Check if any LSP client is attached to the current buffer
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if #clients == 0 then
    vim.notify("No LSP client attached to this buffer", vim.log.levels.WARN)
    return
  end

  -- Check if current file is a Python file
  local filetype = vim.bo.filetype
  if filetype ~= "python" then
    vim.notify("This function is designed for Python files only", vim.log.levels.WARN)
    return
  end

  local params = { textDocument = vim.lsp.util.make_text_document_params() }

  -- Use vim.lsp.buf_request_sync with timeout
  local result = vim.lsp.buf_request_sync(0, "textDocument/documentSymbol", params, 1000)

  if not result or vim.tbl_isempty(result) then
    vim.notify("No symbols found in this file", vim.log.levels.INFO)
    return
  end

  -- Get the first client's result
  local symbols = nil
  for _, res in pairs(result) do
    if res.result then
      symbols = res.result
      break
    end
  end

  if not symbols then
    vim.notify("No symbols found in this file", vim.log.levels.INFO)
    return
  end

  local function cursor_in_range(range)
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    row = row - 1
    local start = range.start
    local finish = range["end"]

    if row < start.line or row > finish.line then
      return false
    elseif row == start.line and col < start.character then
      return false
    elseif row == finish.line and col > finish.character then
      return false
    end
    return true
  end

  local path_parts = {}

  local function find_symbol(symbol_list)
    for _, sym in ipairs(symbol_list) do
      if cursor_in_range(sym.range or sym.location.range) then
        table.insert(path_parts, sym.name)
        if sym.children then
          find_symbol(sym.children)
        end
      end
    end
  end

  find_symbol(symbols)

  if #path_parts == 0 then
    vim.notify("No symbol found under cursor", vim.log.levels.INFO)
    return
  end

  -- Use expand() instead of nvim_buf_get_name
  local file_path = vim.fn.expand("%:p")
  local rel_path = vim.fn.fnamemodify(file_path, ":~:.")
  local module_path = rel_path:gsub("%.py$", ""):gsub("[/\\]", ".")

  local full_path = module_path .. "." .. table.concat(path_parts, ".")
  vim.fn.setreg("+", full_path)
  vim.notify("Copied: " .. full_path, vim.log.levels.INFO)
end

-- Copy symbol path
vim.keymap.set("n", "<leader>cP", get_full_symbol_path, { desc = "Copy path to symbol under cursor" })
