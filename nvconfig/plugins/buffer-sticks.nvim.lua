-- Plugin: ahkohd/buffer-sticks.nvim
-- Installed via store.nvim

return {
  "ahkohd/buffer-sticks.nvim",
  keys = {
    {
      "<leader>j",
      function()
        BufferSticks.jump()
      end,
      desc = "Jump to buffer",
    },
    {
      "<leader>q",
      function()
        BufferSticks.close()
      end,
      desc = "Close buffer",
    },
    {
      "<leader>p",
      function()
        BufferSticks.list({
          action = function(buffer, leave)
            print("Selected: " .. buffer.name)
            leave()
          end,
        })
      end,
      desc = "Buffer picker",
    },
  },
  config = function()
    local sticks = require("buffer-sticks")
    sticks.setup({
      -- Idle indicator overlaps Avante/markdown at the screen edge; only
      -- show during jump/list (<leader>j / <leader>p / <leader>q).
      -- show_indicators=false is required: otherwise leave() re-renders the
      -- idle sticks after jump/list (plugin keeps them visible by design).
      show_by_default = false,
      show_indicators = false,
      filter = {
        buftypes = { "terminal" },
        filetypes = {
          "Avante",
          "AvanteInput",
          "AvanteSelectedFiles",
          "AvanteSelectedCode",
          "AvanteTodos",
          "AvanteConfirm",
          "AvantePromptInput",
        },
      },
      highlights = {
        active = { link = "Statement" },
        alternate = { link = "StorageClass" },
        inactive = { link = "Whitespace" },
        active_modified = { link = "Constant" },
        alternate_modified = { link = "Constant" },
        inactive_modified = { link = "Constant" },
        label = { link = "Comment" },
        filter_selected = { link = "Statement" },
        filter_title = { link = "Comment" },
      },
    })

    -- Plugin BufEnter sets visible=false when show_by_default is off but does
    -- not close an already-open float; force-hide any leftover.
    vim.api.nvim_create_autocmd("BufEnter", {
      group = vim.api.nvim_create_augroup("nvconfig-buffer-sticks-hide", { clear = true }),
      callback = function()
        if BufferSticks and not BufferSticks.is_visible() then
          BufferSticks.hide()
        end
      end,
    })
  end,
}

