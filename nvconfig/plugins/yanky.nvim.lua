-- Plugin: gbprod/yanky.nvim
-- Installed via store.nvim

return {
  "gbprod/yanky.nvim",
  dependencies = {
    { "kkharji/sqlite.lua" },
  },
  config = function()
    require("yanky").setup({
      ring = {
        history_length = 100,
        storage = "sqlite",
        sync_with_numbered_registers = true,
        cancel_event = "update",
        ignore_registers = { "_" },
        update_register_on_cycle = false,
      },
      picker = {
        select = {
          action = nil,
        },
        telescope = {
          use_default_mappings = true,
          mappings = nil,
        },
      },
      system_clipboard = {
        sync_with_ring = true,
      },
      preserve_cursor_position = {
        enabled = true,
      },
      highlight = {
        on_put = true,
        on_yank = true,
        timer = 500,
      },
      textobj = {
        enabled = false,
      },
    })

    -- Keybindings
    local keymap = vim.keymap.set
    local opts = { noremap = true, silent = true }

    -- Yank
    keymap({ "n", "x" }, "y", "<Plug>(YankyYank)", opts)

    -- Put
    keymap({ "n", "x" }, "p", "<Plug>(YankyPutAfter)", opts)
    keymap({ "n", "x" }, "P", "<Plug>(YankyPutBefore)", opts)

    -- Cycle through yank history
    -- keymap("n", "<c-u>", "<Plug>(YankyPreviousEntry)", opts)
    -- keymap("n", "<c-d>", "<Plug>(YankyNextEntry)", opts)

    -- Put with indentation
    keymap("n", "]p", "<Plug>(YankyPutIndentAfterLinewise)", opts)
    keymap("n", "[p", "<Plug>(YankyPutIndentBeforeLinewise)", opts)

    -- Put and adjust indentation
    keymap("n", ">p", "<Plug>(YankyPutIndentAfterShiftRight)", opts)
    keymap("n", "<p", "<Plug>(YankyPutIndentAfterShiftLeft)", opts)

    -- Put and filter
    keymap("n", "=p", "<Plug>(YankyPutAfterFilter)", opts)
    keymap("n", "=P", "<Plug>(YankyPutBeforeFilter)", opts)

    -- Yank history
    keymap({ "n", "x" }, "<leader>h", "<cmd>YankyRingHistory<cr>", opts)
  end,
}
