local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

return require("lazy").setup({
	defaults = {
		lazy = true,
	},

	-- telescope
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.1",
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	-- theme
	{
		"ramojus/mellifluous.nvim",
		lazy = false,
		priority = 1000,
		dependencies = { "rktjmp/lush.nvim" },
		config = function()
			require("mellifluous").setup({
				styles = {
					comments = "",
				},
			}) -- optional, see configuration section.
			vim.cmd("colorscheme mellifluous")
		end,
	},

	-- treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPost", "BufNewFile" },
		build = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
	},

	-- nvim-tree
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons", -- optional
		},
		config = function()
			require("nvim-tree").setup({})
		end,
	},

	-- harpoon
	{
		"theprimeagen/harpoon",
		event = "BufRead",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},

	-- undotree
	"mbbill/undotree",

	-- git / vim-fugitive
	{
		"tpope/vim-fugitive",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"lewis6991/gitsigns.nvim",
		},
		config = function()
			require("gitsigns").setup({
				current_line_blame = true,
			})
		end,
	},

	-- lualine
	"nvim-lualine/lualine.nvim",

	-- Comment
	{ "numToStr/Comment.nvim", event = "BufRead" },

	-- LSP
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v1.x",
		dependencies = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" }, -- Required
			{ "williamboman/mason.nvim" }, -- Optional
			{ "williamboman/mason-lspconfig.nvim" }, -- Optional

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" }, -- Required
			{ "hrsh7th/cmp-nvim-lsp" }, -- Required
			{ "hrsh7th/cmp-buffer" }, -- Optional
			{ "hrsh7th/cmp-path" }, -- Optional
			{ "saadparwaiz1/cmp_luasnip" }, -- Optional
			{ "hrsh7th/cmp-nvim-lua" }, -- Optional

			-- Snippets
			{ "L3MON4D3/LuaSnip" }, -- Required
			{ "rafamadriz/friendly-snippets" }, -- Optional
		},
	},
})
