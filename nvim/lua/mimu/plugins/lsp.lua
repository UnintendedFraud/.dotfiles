return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "j-hui/fidget.nvim",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
    },

    config = function()
        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        local lspconfig = require("lspconfig")
        local configs = require("lspconfig.configs")

        -- elixir config
        local lexical_config = {
            filetypes = { "elixir", "eelixir", "heex" },
            cmd = { "/home/mimu/.local/share/nvim/mason/packages/lexical/libexec/lexical/bin/start_lexical.sh" },
            settings = {},
        }

        if not configs.lexical then
            configs.lexical = {
                default_config = {
                    filetypes = lexical_config.filetypes,
                    cmd = lexical_config.cmd,
                    root_dir = function(fname)
                        return lspconfig.util.root_pattern("mix.exs", ".git")(fname) or vim.loop.os_homedir()
                    end,
                    -- optional settings
                    settings = lexical_config.settings,
                },
            }
        end

        lspconfig.lexical.setup({})

        require("fidget").setup()
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "rust_analyzer",
                "clangd",
                "gopls",
                "lexical",
                "tsserver",
                "intelephense",
            },
            handlers = {
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,

                ["intelephense"] = function()
                    lspconfig.intelephense.setup {
                        root_dir = function(fname)
                            return lspconfig.util.find_git_ancestor(fname) or
                                lspconfig.util.root_pattern("composer.json", ".git")(fname) or
                                lspconfig.util.path.dirname(fname)
                            end
                    }
                end,

                ["gopls"] = function()
                    lspconfig.gopls.setup {
                        settings = {
                            gopls = {
                                analyses = {
                                    unusedparams = true,
                                },
                                staticcheck = true,
                                gofumpt = true,
                            }
                        }
                    }
                end,

                ["lua_ls"] = function()
                    lspconfig.lua_ls.setup {
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "vim" }
                                }
                            }
                        }
                    }
                end,
            }
        })

        local cmp = require("cmp")
        local cmp_select = { behaviour = cmp.SelectBehavior.Select }
        cmp.setup({
            snippet = {
                -- REQUIRED - you must specify a snippet engine
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-p"] = cmp.mapping.select_prev_item(cmp_select),
                ["<C-n"] = cmp.mapping.select_next_item(cmp_select),
                ["<C-y"] = cmp.mapping.confirm({ select = true }),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
                ["<C-Space"] = cmp.mapping.complete(),

                -- Tab
                ["<Tab>"] = function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    else
                        fallback()
                    end
                end,
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" },
            }, {
                { name = "buffer" },
            })
        })

        vim.diagnostic.config({
            virtual_text = true,
            update_on_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end
}
