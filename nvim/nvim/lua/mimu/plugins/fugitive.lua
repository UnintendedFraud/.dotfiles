return {
    "tpope/vim-fugitive",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
        "gitsigns"
	},
	config = function()
        vim.keymap.set("n", "<leader>gs", vim.cmd.Git);

		require("gitsigns").setup({
			current_line_blame = true,
		})
	end,
}
