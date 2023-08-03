require("keys")
require("options")
require("plugins")
-- require("plugins.outline")
-- require("plugins.test")
require("onedark").load()
require("onedark").setup()

vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("HighlightYank", {}),
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 140,
		})
	end,
})
--vim.cmd([[call lexima#add_rule({'char': '"', 'at': '\%#\S\|\S\%#'})]], true)
