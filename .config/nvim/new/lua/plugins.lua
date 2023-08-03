local status, packer = pcall(require, "packer")
if not status then
	print("Packer is not installed")
	return
end

vim.cmd([[packadd packer.nvim]])

packer.startup(function(use)
	use("wbthomason/packer.nvim")
	-- look &  feel
	use("navarasu/onedark.nvim")
	-- use("kyazdani42/nvim-web-devicons")
	-- use("nvim-lualine/lualine.nvim")

	-- Utils
	use("nvim-lua/plenary.nvim")

	-- LSP
	use("williamboman/nvim-lsp-installer")
	use("neovim/nvim-lspconfig")
	use("onsails/lspkind-nvim")
	-- use("jose-elias-alvarez/null-ls.nvim")
	-- use("glepnir/lspsaga.nvim")

	-- Snippets
	-- use("L3MON4D3/LuaSnip") --snippet engine
	-- use({ "rafamadriz/friendly-snippets" }) -- a bunch of snippets to usmaintainede

	-- Completion
	-- use("hrsh7th/nvim-cmp")
	-- use("hrsh7th/cmp-nvim-lsp")
	-- use("hrsh7th/cmp-buffer")
	-- use("hrsh7th/cmp-path")
	-- use("hrsh7th/cmp-cmdline")
	-- use("saadparwaiz1/cmp_luasnip")

	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
		},
	})
	-- use("nvim-telescope/telescope-fzy-native.nvim")
	-- use("nvim-telescope/telescope-symbols.nvim")
	use({ "folke/which-key.nvim" })

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
	})
	use("nvim-treesitter/playground")

	-- Comments
	-- use("tpope/vim-commentary")
	-- use("kylechui/nvim-surround")
	use({ "JoosepAlviste/nvim-ts-context-commentstring" })
end)
