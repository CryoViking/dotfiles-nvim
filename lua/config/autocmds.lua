-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_augroup("AddMuliCommentString", { clear = true })
vim.api.nvim_create_augroup("AddOdinCommentString", { clear = true })
vim.api.nvim_create_augroup("AddCsCommentString", { clear = true })
vim.api.nvim_create_augroup("DisableLSPForCake", { clear = true })

-- Turn off LSP for *.cake files
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = "DisableLSPForCake",
  callback = function()
    vim.defer_fn(function()
      vim.cmd("LspStop")
    end, 100)
  end,
  pattern = { "cake" },
})

-- Comment string for Odin
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = "AddOdinCommentString",
  callback = function()
    vim.bo.commentstring = "// %s"
  end,
  pattern = { "odin" },
})

-- Comment string for C#
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = "AddCsCommentString",
  callback = function()
    vim.bo.commentstring = "// %s"
  end,
  pattern = { "cs" },
})

-- Comment string for Muli BASIC code
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = "AddMuliCommentString",
  callback = function()
    vim.bo.commentstring = "| %s"
  end,
  pattern = { "app", "inc" },
})

vim.api.nvim_create_autocmd({ "FileType", "BufWritePre" }, {
  callback = function()
    local filename = vim.fn.expand("%")
    vim.api.nvim_command("cargo +nightly format -- " .. filename)
  end,
  pattern = { "rs" },
})

-- vim.api.nvim_create_autocmd({ "FileType" }, {
--   callback = function()
--     vim.api.nvim_command("Copilot disable")
--   end,
--   pattern = { "rs", "cs", "cshtml" },
-- })
