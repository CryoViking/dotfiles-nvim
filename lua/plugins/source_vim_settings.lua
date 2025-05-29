local utils = require("plugins.shared.utils")

-- Function to check and source nvim.lua file or alternatively init.lua file
local function source_local_config()
  local cwd = vim.fn.getcwd() -- Get the current working directory

  -- Define the filenames that it could be
  local filename = "nvim.lua"
  local altFilename = "nvim.style"

  -- Check if either of the files exists in the CWD
  local nvimLuaExists = utils.file_exists(cwd .. "/" .. filename)
  local initLuaExists = utils.file_exists(cwd .. "/" .. altFilename)

  -- If any of the files exist, source the first file that exists.
  if nvimLuaExists == true then
    dofile(vim.fn.expand(filename))
    vim.notify("Sourced local config file: " .. filename, vim.log.levels.INFO, {})
  elseif initLuaExists == true then
    dofile(vim.fn.expand(altFilename))
    vim.notify("Sourced local config file: " .. altFilename, vim.log.levels.INFO, {})
  end
end

source_local_config()

return {}
