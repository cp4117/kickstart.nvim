-- C++ open matching cpp/header file.
local function get_file_ext(path)
  return path:match '^.+(%..+)$'
end

local header_source_switch = function()
  local buffer_ext = get_file_ext(vim.api.nvim_buf_get_name(0))

  if buffer_ext ~= nil and string.len(buffer_ext) > 0 then
    print('Buffer ext: ' .. buffer_ext)
    if buffer_ext == '.cpp' then
      vim.cmd ':e %<.h'
    elseif buffer_ext == '.h' then
      vim.cmd ':e %<.cpp'
    end
  end
end

-- Jump between header and cpp files
vim.keymap.set('n', '<A-o>', header_source_switch, { desc = 'Switch between header and cpp files' })
