return {
    {
        "mason-org/mason.nvim",
        lazy = false,
        config = function()
            require("mason").setup()
        end,
    },
    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = {
            "neovim/nvim-lspconfig",
            "mason-org/mason.nvim",
        },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "ts_ls", "pyright", "lua_ls", "eslint" },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        dependencies = {
            "mason-org/mason-lspconfig.nvim",
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-nvim-lsp",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
        },
        config = function()

            require("lspconfig")

            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local cmp = require("cmp")
            require("cmp").setup({
                sources = {
                    { name = "nvim_lsp" },
                    { name = "buffer" },
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-n>"] = cmp.mapping.select_next_item(),
                    ["<C-p>"] = cmp.mapping.select_prev_item(),
                    ["<C-j>"] = cmp.mapping.confirm({ select = true }),
                }),
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
            })
            local on_attach = function(_, bufnr)
                local map = vim.keymap.set
                local opts = { noremap = true, silent = true, buffer = bufnr }

                map('n', '<leader>n', ':cnext<CR>', opts)
                map('n', '<leader>p', ':cprev<CR>', opts)
                map('n', '<leader>a', ':cclose<CR>', opts)

                map('n', 'gd', vim.lsp.buf.definition, opts)
                map('n', 'gy', vim.lsp.buf.type_definition, opts)
                map('n', 'gi', vim.lsp.buf.implementation, opts)
                map('n', 'gr', vim.lsp.buf.references, opts)

                map('n', '[g', vim.diagnostic.goto_prev, opts)
                map('n', ']g', vim.diagnostic.goto_next, opts)

                map('n', '<leader><leader>r', vim.lsp.buf.rename, opts)
                map('n', '<leader>qf', vim.lsp.buf.code_action, opts)
            end

            local servers = {
                ts_ls = {
                    settings = {
                        format = {
                            enable = false, -- Disable tsserver formatting
                        },
                    },
                },
                pyright = {},
                lua_ls = {
                    settings = {
                        Lua = {
                            format = {
                                enable = true,
                            },
                            diagnostics = {
                                globals = { "vim" },
                            },
                        },
                    },
                },
                eslint = {
                    settings = {
                        format = {
                            enable = false,
                        },
                    },
                },
            }

            -- print(vim.inspect(vim.lsp.config))
            for server, config in pairs(servers) do
                config.on_attach = on_attach
                config.capabilities = capabilities
                -- print("Setting up " .. server)
                -- print("Value of vim.lsp.config[" .. server .. "]:", vim.lsp.config[server])
                -- print(vim.inspect(vim.lsp.config[server]))
                vim.lsp.config(server, config)
            end
        end,
    }

}
