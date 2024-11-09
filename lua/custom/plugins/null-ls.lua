return {
    "nvimtools/none-ls.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        local null_ls = require("null-ls")

        null_ls.setup({
            sources = {
                -- formatters
                null_ls.builtins.formatting.prettier,  -- for JS/TS/React
                null_ls.builtins.formatting.gofmt,     -- for Go
                null_ls.builtins.formatting.stylua,    -- for Lua

                -- linters
                null_ls.builtins.diagnostics.eslint,
            },
            -- Format on save
            on_attach = function(client, bufnr)
                if client.supports_method("textDocument/formatting") then
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        buffer = bufnr,
                        callback = function()
                            vim.lsp.buf.format({ bufnr = bufnr })
                        end,
                    })
                end
            end,
        })
    end,
}
