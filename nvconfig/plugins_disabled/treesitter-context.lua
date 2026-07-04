return {
  "nvim-treesitter/nvim-treesitter-context",
  config = function()
    require("treesitter-context").setup({
      enable = true,
      max_lines = 3,
      min_window_height = 0,
      line_numbers = false, -- Don't show line numbers in context window
      multiline_threshold = 20,
      trim_scope = "outer",
      mode = "cursor",
      separator = nil,
      zindex = 20,
    })

    -- Ensure line numbers are always visible
    vim.opt.number = true
    vim.opt.relativenumber = true
  end,
}
