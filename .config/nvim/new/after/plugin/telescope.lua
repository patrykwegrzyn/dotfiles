local status, telescope = pcall(require, "telescope")
if not status then
	return
end

telescope.setup({
	defaults = {
		-- file_ignore_patterns = { "node_modules", "ios", "android" },
		file_ignore_patterns = { "node%_modules", "%.git", "ios", "android" },
		mappings = {
			i = {
				["<C-h>"] = "which_key",
			},
		},
	},
	pickers = {},
	extensions = {
		fzy_native = {
			override_generic_sorter = false,
			override_file_sorter = true,
		}, -- Your extension configuration goes here:
	},
})

telescope.load_extension("fzy_native")
