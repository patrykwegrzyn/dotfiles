local telescope = require("telescope")

telescope.setup({
	defaults = {
		file_ignore_patterns = { "node_modules", "ios", "android" },
		mappings = {
			i = {
				["<C-h>"] = "which_key",
			},
		},
	},
	pickers = {},
	extensions = {
		-- fzy_native = {
		-- 	override_generic_sorter = false,
		-- 	override_file_sorter = true,
		-- }, -- Your extension configuration goes here:
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		},
	},
})

-- telescope.load_extension("fzy_native")
telescope.load_extension("fzf")
