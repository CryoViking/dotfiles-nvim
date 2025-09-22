-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local fzf = require("fzf-lua")

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

-- SECTION: fzf-lua Keymaps
-- File operations
map("n", "<C-p>", fzf.files, { desc = "Find files" })
map("n", "<leader>ff", fzf.files, { desc = "Find files" })
map("n", "<leader>fg", fzf.live_grep, { desc = "Live grep" })
map("n", "<leader>fb", fzf.buffers, { desc = "Find buffers" })
map("n", "<leader>fh", fzf.help_tags, { desc = "Help tags" })
map("n", "<leader>fc", fzf.commands, { desc = "Commands" })
map("n", "<leader>fk", fzf.keymaps, { desc = "Keymaps" })

-- Search operations
map("n", "<leader>fw", fzf.grep_cword, { desc = "Grep word under cursor" })
map("n", "<leader>fW", fzf.grep_cWORD, { desc = "Grep WORD under cursor" })
map("n", "<leader>fr", fzf.resume, { desc = "Resume last command" })
map("n", "<leader>fo", fzf.oldfiles, { desc = "Recent files" })

-- Git operations
map("n", "<leader>gs", fzf.git_status, { desc = "Git status" })
map("n", "<leader>gc", fzf.git_commits, { desc = "Git commits" })
map("n", "<leader>gb", fzf.git_branches, { desc = "Git branches" })
map("n", "<leader>gf", fzf.git_files, { desc = "Git files" })

-- LSP operations (if you use LSP)
map("n", "gd", fzf.lsp_definitions, { desc = "Go to definition" })
map("n", "gr", fzf.lsp_references, { desc = "Find references" })
map("n", "<leader>ds", fzf.lsp_document_symbols, { desc = "Document symbols" })
map("n", "<leader>ws", fzf.lsp_workspace_symbols, { desc = "Workspace symbols" })
map("n", "<leader>ca", fzf.lsp_code_actions, { desc = "Code actions" })
map("n", "<leader>d", fzf.diagnostics_document, { desc = "Document diagnostics" })
map("n", "<leader>D", fzf.diagnostics_workspace, { desc = "Workspace diagnostics" })

-- Visual mode search
map("v", "<leader>fg", fzf.grep_visual, { desc = "Grep selection" })
