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
            max_tokens = lms.fim_max_tokens,
            top_p = lms.fim_toopp,
            temperature = lms.fim_temp,
            stop = lms.fim_stop,
            frequency_penalty = lms.fim_frequency_penalty,
            presence_penalty = lms.fim_presence_penalty,
          },
          template = {
            prompt = function(context_before_cursor, _, _)
              local utils = require("minuet.utils")
              return table.concat({
                utils.add_language_comment(), -- programming lang from extension
                utils.add_tab_comment(), -- indentation style
                "# Use English only for identifiers, comments, and strings.",
                context_before_cursor,
              }, "\n")
            end,
            suffix = function(_, context_after_cursor, _)
              return context_after_cursor
            end,
          },
        },
      },
      virtualtext = {
        auto_trigger_ft = { "*" },
        -- Keep ghost text visible even when blink's completion menu is open.
        show_on_completion_menu = true,
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
