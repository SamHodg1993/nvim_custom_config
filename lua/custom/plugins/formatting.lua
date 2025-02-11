return {
  {
    "jose-elias-alvarez/null-ls.nvim",  -- Changed from nvimtools/none-ls.nvim
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason.nvim",
    },
    config = function()
      local null_ls = require("null-ls")  -- Changed from none-ls to null-ls
      local formatting = null_ls.builtins.formatting
      local diagnostics = null_ls.builtins.diagnostics

      null_ls.setup({
        sources = {
          -- JavaScript/TypeScript/React formatting and linting
          formatting.prettier.with({
            filetypes = {
              "javascript",
              "javascriptreact",
              "typescript",
              "typescriptreact",
              "css",
              "scss",
              "sass",
            },
          }),
          diagnostics.eslint.with({
            filetypes = {
              "javascript",
              "javascriptreact",
              "typescript",
              "typescriptreact",
            },
          }),
          formatting.eslint.with({
            filetypes = {
              "javascript",
              "javascriptreact",
              "typescript",
              "typescriptreact",
            },
          }),

          -- Go formatting
          formatting.goimports,
        },
      })

      -- Set up autoformatting
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = {
          "*.js", "*.jsx", "*.ts", "*.tsx",
          "*.css", "*.scss", "*.sass",
          "*.go"
        },
        callback = function()
          vim.lsp.buf.format({ timeout_ms = 2000 })
        end,
      })

      -- Optional: Add key mappings for manual formatting
      vim.keymap.set('n', '<leader>ff', function()
        vim.lsp.buf.format({ timeout_ms = 2000 })
      end, { desc = "Format file" })
    end,
  }
}
