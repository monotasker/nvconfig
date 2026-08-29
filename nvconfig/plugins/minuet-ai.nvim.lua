-- Minuet (LMS completions)

local lms = require("nvconfig.ai_lms")

return {
  {
    "milanglacier/minuet-ai.nvim",
    event = "InsertEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      provider = "openai_fim_compatible",
      n_completions = 1,
      context_window = 16000,
      throttle = 600,
      debounce = 300,
      provider_options = {
        openai_fim_compatible = {
          api_key = "TERM",
          name = "LMStudio",
          end_point = lms.v1 .. "/completions",
          model = lms.fim_model,
          optional = {
            max_tokens = 128,
            top_p = 0.9,
          },
        },
      },
      virtualtext = {
        auto_trigger_ft = { "*" },
        keymap = {
          accept = "<C-y>",
          accept_line = "<C-S-y>",
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-e>",
        },
      },
    },
  },
}
