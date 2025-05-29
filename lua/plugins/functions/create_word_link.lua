local M = {}

local buffer_utils = require("plugins.shared.buffer_utils")

-- Function to convert word under cursor to a wiki link
M.func = function()
  -- Get current buffer info
  local buf = vim.api.nvim_get_current_buf()
  local win = vim.api.nvim_get_current_win()
  local row, col = unpack(vim.api.nvim_win_get_cursor(win))
  local line = vim.api.nvim_buf_get_lines(buf, row - 1, row, false)[1]

  -- Get filename (without extension) for the link
  local filename = buffer_utils.get_current_buffer_filename(true)

  -- Find the word boundaries
  local word_start = 1
  local word_end = #line

  -- Find the start of the word (scan backward from cursor)
  for i = col, 1, -1 do
    if i == 1 or line:sub(i, i):match("[^%w_]") then
      word_start = (i == 1) and 1 or i + 1
      break
    end
  end

  -- Find the end of the word (scan forward from cursor)
  for i = col, #line do
    if i == #line or line:sub(i + 1, i + 1):match("[^%w_]") then
      word_end = i
      break
    end
  end

  -- Extract the word
  local word = line:sub(word_start, word_end)

  -- Skip if empty or just whitespace
  if word:match("^%s*$") then
    print("No word under cursor")
    return
  end

  -- Create the replacement text
  local replacement = string.format("[[%s#%s|%s]]", filename, word, word)

  -- Create new line with replacement
  local new_line = line:sub(1, word_start - 1) .. replacement .. line:sub(word_end + 1)

  -- Replace the line
  vim.api.nvim_buf_set_lines(buf, row - 1, row, false, { new_line })

  -- Place cursor at the end of the inserted link
  local new_col = word_start + #replacement - 1
  vim.api.nvim_win_set_cursor(win, { row, new_col })

  print(string.format("Created link for '%s'", word))
end

return M
