-- AI: Avante (agent chat + diff review)

local lms = require("nvconfig.ai_lms")

-- Keep nvm's pi / pi-acp visible when Neovim wasn't launched from a login shell.
local nvm_bin = (os.getenv("NVM_DIR") or (os.getenv("HOME") .. "/.nvm")) .. "/versions/node/v24.9.0/bin"
local path_with_nvm = nvm_bin .. ":" .. (os.getenv("PATH") or "")

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
      provider = "pi",
      mode = "agentic",
      acp_providers = {
        pi = {
          -- pi-acp bridges ACP ↔ `pi --mode rpc`; LMS defaults in ~/.pi/agent/
          command = nvm_bin .. "/pi-acp",
          args = {},
          env = {
            HOME = os.getenv("HOME"),
            PATH = path_with_nvm,
          },
        },
        opencode = {
          command = "opencode",
          -- Default model/provider live in ~/.config/opencode/opencode.json
          args = { "acp" },
          env = {
            HOME = os.getenv("HOME"),
            PATH = path_with_nvm,
          },
        },
        cursor = {
          command = vim.fn.expand("~/.local/bin/agent"),
          args = { "acp" },
          auth_method = "cursor_login",
          env = {
            HOME = os.getenv("HOME"),
            PATH = path_with_nvm,
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
        "<leader>ap",
        function()
          require("avante.api").switch_provider("pi")
        end,
        desc = "Avante → Pi ACP",
      },
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
