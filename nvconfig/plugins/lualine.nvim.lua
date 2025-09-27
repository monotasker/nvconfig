-- Plugin: nvim-lualine/lualine.nvim
-- Installed via store.nvim

return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch", "diff", "diagnostics" },
      lualine_c = { "filename" },
      lualine_x = { "encoding", "fileformat", "filetype" },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { "filename" },
      lualine_x = { "location" },
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {
      lualine_a = { "buffers" },
      lualine_b = { "branch" },
      lualine_c = {},
      lualine_x = {},
      lualine_y = { "filename" },
      lualine_z = { "tabs" },
    },
  },
}
