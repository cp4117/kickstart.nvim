-- Clang Formatting
-- Functions to toggle whether clang-formatting is enabled or not and some helper functions to format on write or to manually format

function clang_format_exists()
  local f = io.open('.clang-format', 'r')
  if f ~= nil then
    io.close(f)
    return true
  else
    return false
  end
end

-- On load we enable formatting by default if a .clang-format file can be found in the workspace
Clang_Format_File_Found = clang_format_exists()
Clang_Format_Enabled = Clang_Format_File_Found

Format = function()
  if Clang_Format_Enabled then
    local cursor = vim.api.nvim_win_get_cursor(0)
    vim.cmd '%!clang-format'
    vim.api.nvim_win_set_cursor(0, cursor)
  else
    print 'clang-formatting disabled, skipping format...'
  end
end

-- Toggle formatting enabled/disabled, useful for projects we don't want to have reformatted on a save and generate a large change list
vim.keymap.set('n', '<leader>tf', function()
  Clang_Format_Enabled = not Clang_Format_Enabled
  local msg = 'clang-formatting toggled: ' .. (Clang_Format_Enabled and 'on' or 'off')
  if Clang_Format_Enabled and not Clang_Format_File_Found then
    msg = msg .. '\nWarning no .clang-format file found'
  end
  print(msg)
end, { desc = 'Toggle clang formatting' })

-- Format current file
vim.keymap.set('n', '<leader>cf', function()
  Format()
end, { desc = 'Apply clang format to current file' })

-- Format source files with clang-format on write
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  desc = 'clang-format cpp/h files on write',
  pattern = { '*.c', '*.h', '*.cpp', '*.hpp' },
  callback = Format,
})
