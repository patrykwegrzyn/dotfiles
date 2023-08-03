-- create a scratch unlisted buffer
bufnr = vim.api.nvim_create_buf(false, true)

-- delete buffer when window is closed / buffer is hidden
vim.api.nvim_buf_set_option(bufnr, "bufhidden", "delete")
-- create a split
vim.cmd("botright vs")
-- resize to a % of the current window size
vim.cmd("vertical resize " .. 20)

-- get current (outline) window and attach our buffer to it
winnr = vim.api.nvim_get_current_win()
vim.api.nvim_win_set_buf(winnr, bufnr)

-- window stuff
vim.api.nvim_win_set_option(winnr, "number", false)
vim.api.nvim_win_set_option(winnr, "relativenumber", false)
vim.api.nvim_win_set_option(winnr, "winfixwidth", true)
vim.api.nvim_win_set_option(winnr, "list", false)
-- vim.api.nvim_win_set_option(winnr, "wrap", config.options.wrap)
vim.api.nvim_win_set_option(winnr, "linebreak", true) -- only has effect when wrap=true
vim.api.nvim_win_set_option(winnr, "breakindent", true) -- only has effect when wrap=true
--  Would be nice to use ui.markers.vertical as part of showbreak to keep
--  continuity of the tree UI, but there's currently no way to style the
--  color, apart from globally overriding hl-NonText, which will potentially
--  mess with other theme/user settings. So just use empty spaces for now.
vim.api.nvim_win_set_option(winnr, "showbreak", "      ") -- only has effect when wrap=true.
-- buffer stuff
vim.api.nvim_buf_set_name(bufnr, "OUTLINE")
vim.api.nvim_buf_set_option(bufnr, "filetype", "Outline")
vim.api.nvim_buf_set_option(bufnr, "modifiable", false)
