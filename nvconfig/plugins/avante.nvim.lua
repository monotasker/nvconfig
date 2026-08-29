-- AI: Avante (agent chat + diff review)

local lms = require("nvconfig.ai_lms")

return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false,
    build = "make",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
      "MeanderingProgrammer/render-markdown.nvim",
    },
    opts = {
      provider = "cursor",
      mode = "agentic",
      acp_providers = {
        cursor = {
          command = vim.fn.expand("~/.local/bin/agent"),
          args = { "acp" },
          auth_method = "cursor_login",
          env = {
            HOME = os.getenv("HOME"),
            PATH = os.getenv("PATH"),
          },
        },
        opencode = {
          command = "opencode",
          args = { "acp" },
          env = {
            HOME = os.getenv("HOME"),
            PATH = os.getenv("PATH"),
          },
        },
      },
      providers = {
        lmstudio = {
          __inherited_from = "openai",
          endpoint = lms.v1,
          model = lms.chat_model,
          api_key_name = "TERM",
          timeout = 300000,
          context_window = lms.context_tokens,
          extra_request_body = {
            temperature = 0.75,
            max_tokens = 8192,
          },
        },
      },
    },
    keys = {
      { "<leader>aa", "<cmd>AvanteAsk<cr>", desc = "Avante ask" },
      { "<leader>at", "<cmd>AvanteToggle<cr>", desc = "Avante toggle sidebar" },
      {
        "<leader>ac",
        function()
          require("avante.api").switch_provider("cursor")
        end,
        desc = "Avante → Cursor ACP",
      },
      {
        "<leader>ao",
        function()
          require("avante.api").switch_provider("opencode")
        end,
        desc = "Avante → OpenCode ACP",
      },
      {
        "<leader>al",
        function()
          require("avante.api").switch_provider("lmstudio")
        end,
        desc = "Avante → LMS direct",
      },
    },
  },
}
