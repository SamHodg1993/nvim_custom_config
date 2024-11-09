return {
    {
        "williamboman/mason.nvim",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",

		"hrsh7th/nvim-cmp",         -- Completion plugin
		"hrsh7th/cmp-nvim-lsp",     -- LSP completion
		"L3MON4D3/LuaSnip",         -- Snippet engine
		"saadparwaiz1/cmp_luasnip", -- Snippet completion
		"rafamadriz/friendly-snippets" -- Preconfigured snippets
        },
        config = function()
            -- Set up Mason
            require("mason").setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗"
                    }
                }
            })

            -- Set up Mason LSP config
            require("mason-lspconfig").setup({
                -- List of LSP servers to automatically install
                ensure_installed = {
                    "lua_ls",          -- Lua
                    -- "tsserver",        -- TypeScript/JavaScript
                    "ts_ls",        -- TypeScript/JavaScript
                    "gopls",           -- Go
                    "cssls",           -- CSS
                    "html",            -- HTML
                },
                automatic_installation = true,
            })

            -- Set up LSP servers
            local lspconfig = require('lspconfig')
            
            -- Capabilities for better completion
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            
            -- Set up each LSP server
            lspconfig.lua_ls.setup({
                capabilities = capabilities,
            })
            
            lspconfig.ts_ls.setup({
                capabilities = capabilities,
            })
            
            lspconfig.gopls.setup({
                capabilities = capabilities,
            })
            
            lspconfig.cssls.setup({
                capabilities = capabilities,
            })
            
            lspconfig.html.setup({
                capabilities = capabilities,
            })

            -- Global LSP keybindings
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Go to declaration' })
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover documentation' })
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'Go to implementation' })
            vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code actions' })
            vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename symbol' })
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'Find references' })
            vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Show diagnostics' })
        end,
    },
}
