-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

map("n", "<leader>i", function()
  -- If we find a floating window, close it.
  local found_float = false
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_config(win).relative ~= "" then
      vim.api.nvim_win_close(win, true)
      found_float = true
    end
  end

  if found_float then
    return
  end

  vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" })
end, { desc = "Toggle Diagnostics" })

map({ "n", "v" }, "<C-j>", "5j")
map({ "n", "v" }, "<C-k>", "5k")

map("v", "<A-Down>", ":m '>+1<CR>gv=gv")
map("v", "<A-Up>", ":m '<-2<CR>gv=gv")

map("n", "<A-Down>", ":m +1<CR>gv=gv")
map("n", "<A-Up>", ":m -2<CR>gv=gv")
-- greatest remap ever because this really annoys me
-- paste over the selected line, with sending the replaced
-- content to the blackhole register
map("x", "<leader>p", '"_dP')

-- copy into the system register
map("n", "<leader>y", '"+y')
map("v", "<leader>y", '"+y')
map("n", "<leader>Y", '"+Y')

-- delete into the blackhole register
map({ "n", "v" }, "<leader>d", '"_d')

map("i", "<C-l>", "<Esc>")

-- refactor within file
map("n", "<C-r>", ":%s/<C-r><C-w>//gI<Left><Left><Left>")

-- Open lazy git while in terminal mode.
-- map("t", "<C-.>", "<cmd>LazyGit<CR>")

-- SECTION: keymaps for functions
local create_word_link = require("plugins.functions.create_word_link")
vim.keymap.set("n", "<leader>Wl", create_word_link.func, { desc = "Create word link" })
