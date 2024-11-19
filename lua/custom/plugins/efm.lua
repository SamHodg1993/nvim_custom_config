return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lspconfig = require("lspconfig")

      -- Define formatters and linters
      local prettier = {
        formatCommand = "prettier --stdin-filepath ${INPUT}",
        formatStdin = true,
      }

      local eslint = {
        lintCommand = "eslint -f unix --stdin --stdin-filename ${INPUT}",
        lintStdin = true,
        lintFormats = { "%f:%l:%c: %m" },
        lintIgnoreExitCode = true,
        formatCommand = "eslint --fix-to-stdout --stdin --stdin-filename=${INPUT}",
        formatStdin = true
      }

      local goimports = {
        formatCommand = "goimports",
        formatStdin = true
      }

      -- Configure efm with all the languages
      lspconfig.efm.setup({
        init_options = { documentFormatting = true },
        filetypes = {
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
          "css",
          "scss",
          "sass",
          "go",
        },
        settings = {
          languages = {
            javascript = { prettier, eslint },
            javascriptreact = { prettier, eslint },
            typescript = { prettier, eslint },
            typescriptreact = { prettier, eslint },
            css = { prettier },
            scss = { prettier },
            sass = { prettier },
            go = { goimports },
          }
        }
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
