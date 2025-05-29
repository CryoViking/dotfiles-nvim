local M = {}

local buffer_utils = require("plugins.shared.buffer_utils")

-- Function to update or create a Quick Links section with links to all ### headers
M.func = function()
  -- Get all lines in the current buffer
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

  -- Detect the document title/filename for the link pattern
  local doc_title = buffer_utils.get_current_buffer_filename(true)

  -- Find all ### headers and their line numbers
  local headers = {}
  local first_header_line = nil
  local quick_links_line = nil

  for i, line in ipairs(lines) do
    -- Check if this line contains the Quick Links section
    if line:match("^####%s+Quick%s+Links") then
      quick_links_line = i
    end

    -- Check if this line is a ### header
    -- Check for ## headers
    local h2_text = line:match("^##%s+(.+)")
    -- Check for ### headers
    local h3_text = line:match("^###%s+(.+)")

    if h2_text or h3_text then
      if first_header_line == nil then
        first_header_line = i
      end

      table.insert(headers, {
        line = i,
        level = h2_text and 2 or 3,
        text = h2_text or h3_text,
      })
    end
  end

  -- Generate the Quick Links content
  local links = {}
  for _, header in ipairs(headers) do
    -- Create links in the format [[Primary Design#Webserver|Webserver]]
    local link_text = string.format("[[%s#%s|%s]]", doc_title, header.text, header.text)

    -- Add indentation for level 3 headers (###)
    if header.level == 3 then
      link_text = "    " .. link_text
    end

    table.insert(links, link_text)
  end

  local quick_links_content = { "#### Quick Links" }
  for _, link in ipairs(links) do
    table.insert(quick_links_content, link)
  end
  table.insert(quick_links_content, "") -- Add a blank line after links

  -- Update or create Quick Links section
  if quick_links_line then
    -- Delete existing Quick Links section (including the header line)
    local section_end = quick_links_line

    -- Find the end of the quick links section by looking for first blank line or next header
    local found_end = false
    while section_end < #lines and not found_end do
      section_end = section_end + 1

      -- Stop at first blank line after Quick Links header
      if lines[section_end] == "" then
        found_end = true
      end

      -- Also stop if we hit a header
      if lines[section_end]:match("^###?%s+") then
        found_end = true
        section_end = section_end - 1 -- Don't include the header in the replacement
      end
    end

    vim.api.nvim_buf_set_lines(0, quick_links_line - 1, section_end, false, quick_links_content)
  else
    -- Create a new Quick Links section before the first header
    if first_header_line then
      vim.api.nvim_buf_set_lines(0, first_header_line - 1, first_header_line - 1, false, quick_links_content)
    else
      -- If no headers found, just add at the end of the document
      vim.api.nvim_buf_set_lines(0, #lines, #lines, false, quick_links_content)
    end
  end
end

return M
