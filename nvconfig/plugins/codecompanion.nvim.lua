-- Plugin: olimorris/codecompanion.nvim
-- Installed via store.nvim

return {
  "olimorris/codecompanion.nvim",
  opts = {
    strategies = {
      chat = {
        name = "ollama",
        model = "qwen3:30b-a3b",
      },
    },
  },
  requires = {
    "nvim-lua/plenary.nvim",
  },
  event = "VeryLazy",
}
