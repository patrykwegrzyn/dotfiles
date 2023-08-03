local map = vim.api.nvim_set_keymap
local opt = { noremap = true, silent = false }

-- Better tabbing
map("v", "<", "<gv", opt)
map("v", ">", ">gv", opt)

-- Navigate buffers
map("n", "<S-l>", ":bnext<CR>", opt)
map("n", "<S-h>", ":bprevious<CR>", opt)

map("n", "zz", ":update<CR>", opt)
