require("mimu.set")
require("mimu.remap")
require("mimu.lazy")

local augroup = vim.api.nvim_create_augroup
local MimuGroup = augroup("mimu", {})

local autocmd = vim.api.nvim_create_autocmd

vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]

autocmd("LspAttach", {
    group = MimuGroup,
    callback = function(e)
        local opts = { buffer = e.buf }
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set("n", "<leader>vd", function() vim.lsp.diagnostic.open_float() end, opts)
        -- vim.keymap.set("n", "[d", function() vim.lsp.diagnostic.goto_next() end, opts)
        -- vim.keymap.set("n", "]d", function() vim.lsp.diagnostic.goto_prev() end, opts)
        vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
    end
})
