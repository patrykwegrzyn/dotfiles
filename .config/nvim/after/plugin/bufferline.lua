require("bufferline").setup({
	options = {
		mappings = true,
		mode = "buffers",
		numbers = function(opts)
			local tmpid = opts.ordinal > 9 and 10 or opts.ordinal
			local icons = { "", "", "", "", "", "", "", "", "", "" }
			return icons[tmpid]
		end,
	},
	highlights = {
		fill = {
			fg = "bg",
			bg = "#282C32",
		},
		background = {
			bg = "#242528",
		},
		close_button = {
			bg = "#282C32",
		},
		separator = {
			bg = "#282C32",
		},
		tab_close = {
			fg = "#ABB2BF",
			bg = "#282C32",
		},
	},
})

vim.keymap.set("n", "gb", "<cmd>BufferLinePick<cr>", { silent = true })
vim.keymap.set("n", "<LEADER>1", '<cmd>lua require("bufferline").go_to_buffer(1, true)<cr>', { silent = true })
vim.keymap.set("n", "<LEADER>2", '<cmd>lua require("bufferline").go_to_buffer(2, true)<cr>', { silent = true })
vim.keymap.set("n", "<LEADER>3", '<cmd>lua require("bufferline").go_to_buffer(3, true)<cr>', { silent = true })
vim.keymap.set("n", "<LEADER>4", '<cmd>lua require("bufferline").go_to_buffer(4, true)<cr>', { silent = true })
vim.keymap.set("n", "<LEADER>5", '<cmd>lua require("bufferline").go_to_buffer(5, true)<cr>', { silent = true })
vim.keymap.set("n", "<LEADER>6", '<cmd>lua require("bufferline").go_to_buffer(6, true)<cr>', { silent = true })
vim.keymap.set("n", "<LEADER>7", '<cmd>lua require("bufferline").go_to_buffer(7, true)<cr>', { silent = true })
vim.keymap.set("n", "<LEADER>8", '<cmd>lua require("bufferline").go_to_buffer(8, true)<cr>', { silent = true })
vim.keymap.set("n", "<LEADER>9", '<cmd>lua require("bufferline").go_to_buffer(9, true)<cr>', { silent = true })
