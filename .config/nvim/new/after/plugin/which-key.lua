local status, wk = pcall(require, "which-key")
if not status then
	return
end

wk.setup({})

wk.register({
	f = {
		name = "files",
		f = { "<cmd>Telescope find_files<cr>", "Find File" }, -- create a binding with label
		j = { "<cmd>Telescope jumplist<cr>", "Show Jumplist" }, -- create a binding with label
		F = { ":lua vim.lsp.buf.formatting()<CR>", "Format File" }, -- create a binding with label
		-- F = {"<cmd>Format<cr>", "Format File"}, -- create a binding with label
		b = { "<cmd>Telescope file_browser<cr>", "File Browser" }, -- create a binding with label
		["1"] = "which_key_ignore", -- special label to hide it in the popup
	},
	L = {
		name = "Lsp stuff",
		i = { "<cmd>LspInfo<cr>", "Lsp Info" }, -- create a binding with label
	},

	d = {
		name = "Delete stuff",
		c = { "<cmd>g/console.log/d<cr>", "Delete All console logs" },
	},
	t = {
		name = "Telescope",
		b = { "<cmd>Telescope buffers<cr>", "Buffer Browser" }, -- create a binding with label
		c = { "<cmd>Telescope neoclip<cr>", "Buffer Clipboard" }, -- create a binding with label
	},
	u = {
		name = "Utils",
		r = { "<Plug>RestNvim", "Http Run" },
	},
}, { prefix = "<leader>" })
