local map = vim.api.nvim_set_keymap
local opt = { noremap = true, silent = false }

-- Better tabbing
map("v", "<", "<gv", opt)
map("v", ">", ">gv", opt)

-- Navigate buffers
map("n", "<S-l>", ":bnext<CR>", opt)
map("n", "<S-h>", ":bprevious<CR>", opt)

-- Navigate splits
map("n", "<C-L>", "<C-W><C-L>", opt)
map("n", "<C-H>", "<C-W><C-H>", opt)

map("n", "zz", ":update<CR>", opt)
map("i", "jk", "<Esc>", opt)
