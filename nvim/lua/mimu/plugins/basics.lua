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

    {
        "nvim-lua/plenary.nvim",
        name = "plenary"
    },

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
