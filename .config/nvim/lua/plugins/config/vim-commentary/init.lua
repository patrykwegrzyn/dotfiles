
local augroup = vim.api.nvim_create_augroup   -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd   -- Create autocommand

augroup('tidalComments', { clear = true })
autocmd('Filetype', {
  group = 'tidalComments',
  pattern = { 'tidal'},
  command = "setlocal commentstring=--\\ %s"
})
