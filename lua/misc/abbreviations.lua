-- abbreviations
-- common abbreviations to add different styled comments to a file depending on the file type

vim.api.nvim_create_autocmd('FileType', {
  pattern = { '*.cpp', '*.js', '*.h', '*.hpp' },
  callback = function()
    vim.cmd 'iabbrev <buffer> todo // TODO(chris.pearce):'
    vim.cmd 'iabbrev <buffer> note // NOTE(chris.pearce):'
    vim.cmd 'iabbrev <buffer> hack // HACK(chris.pearce):'
    vim.cmd 'iabbrev <buffer> fix // FIX(chris.pearce):'
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'ps1',
  callback = function()
    vim.cmd 'iabbrev <buffer> todo # TODO(chris.pearce):'
    vim.cmd 'iabbrev <buffer> note # NOTE(chris.pearce):'
    vim.cmd 'iabbrev <buffer> hack # HACK(chris.pearce):'
    vim.cmd 'iabbrev <buffer> fix # FIX(chris.pearce):'
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'lua',
  callback = function()
    vim.cmd 'iabbrev <buffer> todo -- TODO(chris.pearce):'
    vim.cmd 'iabbrev <buffer> note -- NOTE(chris.pearce):'
    vim.cmd 'iabbrev <buffer> hack -- HACK(chris.pearce):'
    vim.cmd 'iabbrev <buffer> fix -- FIX(chris.pearce):'
  end,
})
