-- Plugin: outline.nvim
-- Installed via Lazy.nvim

return {
  "hedyhli/outline.nvim",
  event = "VeryLazy",
  config = function()
    require("outline").setup({
      -- Configuration options
      outline_window = {
        width = 30,
        position = "right",
        border = "rounded",
      },
      preview_window = {
        width = 40,
        position = "right",
        border = "rounded",
      },
      keymaps = {
        close = { "<Esc>", "q" },
        goto_location = "<Cr>",
        focus_location = "o",
        hover_symbol = "<C-space>",
        toggle_preview = "K",
        rename_symbol = "r",
        code_actions = "a",
        fold = "h",
        unfold = "l",
        fold_all = "W",
        unfold_all = "E",
        fold_reset = "R",
      },
    })
  end,
}