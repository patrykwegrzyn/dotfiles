local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

augroup('tidalcomments', { clear = true })
autocmd('Filetype', {
  group = 'tidalcomments',
  pattern = { 'tidal },
  command = 'setlocal commentstring=--\ %s'
})

-- vim.api.nvim_command([[
--   augroup Tidal
--     autocmd!
--     autocmd FileType tidal setlocal commentstring=--\ %s
--   augroup END
-- ]])
-- ddsd
