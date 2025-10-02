-- Plugin: nvim-telescope/telescope.nvim
-- Installed via store.nvim

return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  event = "VeryLazy",
  config = function()
    require("telescope").setup({
      -- Standard Telescope setup - no custom previewers needed
      defaults = {
        path_display = { "truncate" },
      },
      pickers = {
        find_files = {
          find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
        },
      },
    })
  end,
}
