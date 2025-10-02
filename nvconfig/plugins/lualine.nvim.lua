-- Plugin: nvim-lualine/lualine.nvim
-- Installed via store.nvim

return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  -- optional = true,
  opts = {
    extensions = {
      "aerial",
      "neo-tree",
      "nvim-dap-ui",
      "quickfix",
      "toggleterm",
      "trouble",
    },

    filetype_names = {
      TelescopePrompt = "Telescope",
      dashboard = "Dashboard",
      packer = "Packer",
      fzf = "FZF",
      alpha = "Alpha",
    }, -- Shows specific window name for that filetype ( { `filetype` = `window_name`, ... } )

    disabled_buftypes = { "quickfix", "prompt" }, -- Hide a window if its buffer's type is disabled
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch", "diff", "diagnostics" },
      lualine_c = { { "navic", color_correction = "dynamic" } },
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
    -- tabline = {
    --   lualine_a = {
    --     {
    --       "buffers",
    --       component_separators = { left = "", right = "" },
    --       section_separators = { left = "", right = "" },
    --       -- section_separators = { left = "", right = "" },
    --       -- component_separators = { left = "", right = "" },
    --       left_padding = 2,
    --       right_padding = 2,
    --       show_modified_status = true,
    --       mode = 2,
    --       -- max_length = 40,
    --       symbols = {
    --         modified = " ●",
    --         alternate_file = "#",
    --         directory = "",
    --       },
    --     },
    --   },
    --   lualine_b = {},
    --   lualine_c = {},
    --   lualine_x = {},
    --   lualine_y = { "filename" },
    --   lualine_z = { "datetime", style = "%H:%M" },
    -- },
  },
}
