-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- telescope
  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.1',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- theme
  use({
    'ramojus/mellifluous.nvim',
    requires = { 'rktjmp/lush.nvim' },
    config = function()
        require'mellifluous'.setup({
          styles = {
            comments = '',
          },
        }) -- optional, see configuration section.
        vim.cmd('colorscheme mellifluous')
    end
  })


  -- treesitter
  use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})

  -- nvim-tree
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional
    },
    config = function()
      require("nvim-tree").setup {}
    end
  }

  -- harpoon
  use("theprimeagen/harpoon")

  -- undotree
  use("mbbill/undotree")

  -- git / vim-fugitive
  use("tpope/vim-fugitive")
  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup({
          current_line_blame = true,
      })
    end
  }

  -- lualine
  use {'nvim-lualine/lualine.nvim'}

  -- Comment
  use {'numToStr/Comment.nvim'}

  -- LSP
  use {
	  'VonHeikemen/lsp-zero.nvim',
	  branch = 'v1.x',
	  requires = {
		  -- LSP Support
		  {'neovim/nvim-lspconfig'},             -- Required
		  {'williamboman/mason.nvim'},           -- Optional
		  {'williamboman/mason-lspconfig.nvim'}, -- Optional

		  -- Autocompletion
		  {'hrsh7th/nvim-cmp'},         -- Required
		  {'hrsh7th/cmp-nvim-lsp'},     -- Required
		  {'hrsh7th/cmp-buffer'},       -- Optional
		  {'hrsh7th/cmp-path'},         -- Optional
		  {'saadparwaiz1/cmp_luasnip'}, -- Optional
		  {'hrsh7th/cmp-nvim-lua'},     -- Optional

		  -- Snippets
		  {'L3MON4D3/LuaSnip'},             -- Required
		  {'rafamadriz/friendly-snippets'}, -- Optional
	  }
  }
end)
