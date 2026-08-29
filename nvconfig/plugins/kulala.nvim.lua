-- Plugin: mistweaverco/kulala.nvim
-- Postman-style HTTP client for *.http files.
--
-- Credentials via simplesec (preferred):
--   require("nvconfig.kulala.simplesec").inject_token()  -- in a pre-request block
--   examples: lua/nvconfig/kulala/examples/sample.http
-- Docs: https://kulala.app/usage/environments
--       https://kulala.app/usage/secrets-managers

return {
  "mistweaverco/kulala.nvim",
  keys = {
    { "<leader>Rs", desc = "Send request" },
    { "<leader>Ra", desc = "Send all requests" },
    { "<leader>Rb", desc = "Open scratchpad" },
    { "<leader>Re", desc = "Select environment" },
  },
  ft = { "http", "rest" },
  opts = {
    -- Enables <leader>R* maps (send, env select, replay, etc.)
    global_keymaps = true,
    global_keymaps_prefix = "<leader>R",
    kulala_keymaps_prefix = "",
    default_env = "dev",
    -- Keep script messages in Kulala's script pane only — do not mirror
    -- client.log to vim.notify (avoids secrets-adjacent text in notify history).
    script_console_notify = false,
  },
}
