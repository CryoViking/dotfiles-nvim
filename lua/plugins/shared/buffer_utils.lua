local M = {}

-- Get the full file path of the current buffer
M.get_current_buffer_file_path = function()
  return vim.api.nvim_buf_get_name(0)
end

-- Get just the filename of the current buffer
-- @param remove_extension boolean: if true, removes the file extension
M.get_current_buffer_filename = function(remove_extension)
  local full_path = vim.api.nvim_buf_get_name(0)
  local modifier = remove_extension and ":t:r" or ":t"
  return vim.fn.fnamemodify(full_path, modifier)
end

-- Get the file path of a specific buffer by buffer number
M.get_buffer_file_path = function(bufnr)
  return vim.api.nvim_buf_get_name(bufnr)
end

-- Get just the filename of a specific buffer by buffer number
-- @param bufnr number: the buffer number
-- @param remove_extension boolean: if true, removes the file extension
M.get_buffer_filename = function(bufnr, remove_extension)
  local full_path = vim.api.nvim_buf_get_name(bufnr)
  local modifier = remove_extension and ":t:r" or ":t"
  return vim.fn.fnamemodify(full_path, modifier)
end

-- Get the directory of the current buffer
M.get_current_buffer_directory = function()
  local full_path = vim.api.nvim_buf_get_name(0)
  return vim.fn.fnamemodify(full_path, ":h")
end

-- Get filename without extension of the current buffer
M.get_current_buffer_filename_no_ext = function()
  local full_path = vim.api.nvim_buf_get_name(0)
  return vim.fn.fnamemodify(full_path, ":t:r")
end

-- Get filename without extension of a specific buffer
M.get_buffer_filename_no_ext = function(bufnr)
  local full_path = vim.api.nvim_buf_get_name(bufnr)
  return vim.fn.fnamemodify(full_path, ":t:r")
end

return M
