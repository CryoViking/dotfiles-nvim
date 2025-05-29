-- Function to check if a file exists at the given path and is readable.
local function file_exists(filename)
  local file = io.open(filename, "r")
  if file then
    file:close()
    return true
  end
  return false
end

local module = {}
module.file_exists = file_exists
return module
