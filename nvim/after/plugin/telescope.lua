local builtin = require("telescope.builtin")

local M = {}

M.project_files = function()
	local opts = require("telescope.themes").get_ivy({})
	opts.find_command = { "rg", "--files", "--hidden", "--follow", "--glob", "!.git/*" }
	vim.fn.system("git rev-parse --is-inside-work-tree")
	if vim.v.shell_error == 0 then
		builtin.git_files(opts)
	else
		opts.hidden = true
		builtin.find_files(opts)
	end
end

vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
vim.keymap.set("n", "<C-p", M.project_files, {})
vim.keymap.set("n", "<leader>ps", function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
