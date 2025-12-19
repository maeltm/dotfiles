return {
    {
        "nvimtools/none-ls.nvim", -- null-ls는 이름이 바뀌었어!
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local null_ls = require("null-ls")
            local utils = require("null-ls.utils")

            local prettier_local = utils.path.join(utils.get_root(), "node_modules", ".bin", "prettier")
            local has_prettier = vim.fn.executable(prettier_local) == 1

            if has_prettier then
                vim.notify("[null-ls] Prettier found, enabling formatter", vim.log.levels.INFO)
            else
                vim.notify("[null-ls] Prettier NOT found, skipping formatter", vim.log.levels.WARN)
            end

            null_ls.setup({
                debug = true,
                sources = {
                    null_ls.builtins.formatting.prettier,
                },
                -- sources = has_prettier and {
                --     -- formatters
                --     null_ls.builtins.formatting.prettier.with({
                --         filetypes = {
                --             "javascript", "typescript", "typescriptreact", "javascriptreact",
                --             "vue", "css", "scss", "html", "json", "yaml", "markdown", "graphql",
                --         },

                --         extra_args = function(params)
                --             local ignore_path = params.root .. "/.prettierignore"
                --             local file_exists = vim.fn.filereadable(ignore_path) == 1
                --             print("[Prettier] ignore_path:", ignore_path, "exists:", file_exists)
                --             print("[Prettier] stdin-filepath:", params.bufname)

                --             return {
                --                 "--ignore-path", ignore_path,
                --             }
                --         end,
                --         cwd = function(params)
                --             local root = utils.root_pattern(
                --                 ".prettierrc",
                --                 ".prettierrc.js",
                --                 ".prettierrc.json",
                --                 ".prettierignore",
                --                 "package.json",
                --                 ".git"
                --             )(params.bufname)

                --             local ignore_path = root and (root .. "/.prettierignore") or nil
                --             local exists = ignore_path and vim.loop.fs_stat(ignore_path) ~= nil

                --             -- 로그 출력
                --             vim.schedule(function()
                --                 vim.notify(("[null-ls] Prettier CWD: %s"):format(root or "nil"), vim.log.levels.INFO)
                --                 vim.notify(("[null-ls] .prettierignore %s"):format(exists and "FOUND" or "NOT FOUND"),
                --                     vim.log.levels.INFO)
                --             end)

                --             return root
                --         end,
                --     }),
                -- } or {},
                on_attach = function(client, bufnr)
                    if client.supports_method("textDocument/formatting") then
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            buffer = bufnr,
                            callback = function()
                                -- print("Formatting buffer with null-ls...")
                                vim.lsp.buf.format({ async = false,
                                    filter = function(fmt_client)
                                        -- print("Formatter client:", fmt_client.name)
                                        return fmt_client.name == "null-ls"
                                    end,
                                })
                            end,
                        })
                    end
                    if client.supports_method("textDocument/publishDiagnostics") then
                        vim.api.nvim_clear_autocmds({ group = "DiagnosticDisplay", buffer = bufnr })
                        vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
                            group = vim.api.nvim_create_augroup("DiagnosticDisplay", { clear = true }),
                            buffer = bufnr,
                            callback = function()
                                vim.diagnostic.enable(bufnr)
                            end,
                        })
                    end
                end,
            })
        end,
    },
}
