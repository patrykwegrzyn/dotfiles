local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
end
-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

local config = function(name)
	return "require('plugins/config/" .. name .. "')"
end

local plugs = {
	-- look &  feel
	"navarasu/onedark.nvim",
	"kyazdani42/nvim-web-devicons",
	"nvim-lualine/lualine.nvim",
}

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")

	-- look &  feel
	use("navarasu/onedark.nvim")
	use("kyazdani42/nvim-web-devicons")
	use({ "nvim-lualine/lualine.nvim", config = config("lualine") })
	use("glepnir/lspsaga.nvim")

	-- navigation
	use("unblevable/quick-scope")
	use({
		"nvim-telescope/telescope.nvim",
		config = config("telescope"),
		requires = {
			"nvim-lua/plenary.nvim",
		},
	})
	use("nvim-telescope/telescope-fzy-native.nvim")
	use({ "folke/which-key.nvim", config = config("which-key") })
	-- use({ "windwp/nvim-autopairs" })
	use({ "windwp/nvim-autopairs", config = config("autopairs") })
	use({ "windwp/nvim-ts-autotag", config = config("autotag") })

	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		-- event = "BufWinEnter",
		config = config("treesitter"),
	})
	use("nvim-treesitter/playground")
	-- use "p00f/nvim-ts-rainbow"
	-- lsp
	use("williamboman/nvim-lsp-installer")
	use({
		"neovim/nvim-lspconfig",
		config = config("lsp"),
	})
	-- completion
	use({ "hrsh7th/nvim-cmp", config = config("cmp") })
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	-- snippets
	use("L3MON4D3/LuaSnip") --snippet engine
	use({ "rafamadriz/friendly-snippets", config = config("luasnip") }) -- a bunch of snippets to usmaintainede
	use("saadparwaiz1/cmp_luasnip")
	-- utils
	use({ "jose-elias-alvarez/null-ls.nvim", config = config("null-ls") })
	use({ "AckslD/nvim-neoclip.lua", config = config("nvim-neoclip") })

	use("tpope/vim-commentary")
	use("kylechui/nvim-surround")
	use({ "JoosepAlviste/nvim-ts-context-commentstring", config = config("tscc") })
	use("MunifTanjim/prettier.nvim")

	use({ "NTBBloodbath/rest.nvim", config = config("http") })
	if packer_bootstrap then
		require("packer").sync()
	end
end)
