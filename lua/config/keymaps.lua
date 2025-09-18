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

local function get_full_symbol_path()
  local params = { textDocument = vim.lsp.util.make_text_document_params() }
  vim.lsp.buf_request(0, "textDocument/documentSymbol", params, function(err, result, _, _)
    if err or not result then
      print("No symbols found")
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

    local function find_symbol(symbols)
      for _, sym in ipairs(symbols) do
        if cursor_in_range(sym.range or sym.location.range) then
          table.insert(path_parts, sym.name)
          if sym.children then
            find_symbol(sym.children)
          end
        end
      end
    end

    find_symbol(result)

    if #path_parts == 0 then
      print("No symbol found under cursor")
      return
    end

    -- Use expand() instead of nvim_buf_get_name
    local file_path = vim.fn.expand("%:p")
    local rel_path = vim.fn.fnamemodify(file_path, ":~:.")
    local module_path = rel_path:gsub("%.py$", ""):gsub("[/\\]", ".")

    local full_path = module_path .. "." .. table.concat(path_parts, ".")
    vim.fn.setreg("+", full_path)
    print("Copied: " .. full_path)
  end)
end

-- Copy symbol path
vim.keymap.set("n", "<leader>cP", get_full_symbol_path, { desc = "Copy path to symbol under cursor" })
