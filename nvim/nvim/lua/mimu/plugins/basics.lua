return {
    -- Color scheme
  {
    "rktjmp/lush.nvim",
    name = "lush",
    priority = 1000,
  },

    {
		"ramojus/mellifluous.nvim",
        dependencies = {
            "lush"
        },
		config = function()
			vim.cmd("colorscheme mellifluous")
		end,
    },

    -- telescope
    {
        "nvim-lua/plenary.nvim",
        name = "plenary"
    },

    -- trouble / diagnostics
    { 
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup({
                icons = false,
            })
        end
    },

    -- fugitive / git
    {
	    "lewis6991/gitsigns.nvim",
        name = "gitsigns",
    },

	-- Comment
	{ 
        "numToStr/Comment.nvim", 
        event = "BufRead",
        config = function()
            require("Comment").setup()
        end
    },


}
