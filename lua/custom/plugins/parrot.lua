return {
  "frankroeder/parrot.nvim",
  dependencies = { 'ibhagwan/fzf-lua', 'nvim-lua/plenary.nvim',"rcarriga/nvim-notify"   },
  -- optionally include "rcarriga/nvim-notify" for beautiful notifications
  config = function()
    require("parrot").setup {
      -- Providers must be explicitly added to make them available.
      providers = {
        anthropic = {
          api_key = os.getenv "CLAUDE_API_KEY",
        },
        gemini = {
          api_key = os.getenv "GEMINI_API_KEY",
        },
        groq = {
          api_key = os.getenv "GROQ_API_KEY",
        },
        mistral = {
          api_key = os.getenv "MISTRAL_API_KEY",
        },
        pplx = {
          api_key = os.getenv "PERPLEXITY_API_KEY",
        },
        -- provide an empty list to make provider available (no API key required)
        -- ollama = {},
        openai = {
          api_key = os.getenv "OPENAI_API_KEY",
        },
        github = {
          api_key = os.getenv "GITHUB_TOKEN",
        },
        nvidia = {
          api_key = os.getenv "NVIDIA_API_KEY",
        },
        xai = {
          api_key = os.getenv "XAI_API_KEY",
        },
      },
      -- Local chat buffer shortcuts
      chat_shortcut_respond = { modes = { "n", "i", "v", "x" }, shortcut = "<C-e>" },
      chat_shortcut_delete = { modes = { "n", "i", "v", "x" }, shortcut = "<C-g>d" },
      chat_shortcut_stop = { modes = { "n", "i", "v", "x" }, shortcut = "<C-g>s" },
      chat_shortcut_new = { modes = { "n", "i", "v", "x" }, shortcut = "<C-g>c" },
    }
  end,
}
