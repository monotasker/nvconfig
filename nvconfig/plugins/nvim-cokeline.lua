-- Plugin: willothy/nvim-cokeline
-- Installed via store.nvim

return {
  "willothy/nvim-cokeline",
  dependencies = {
    "nvim-lua/plenary.nvim", -- Required for v0.4.0+
    "nvim-tree/nvim-web-devicons", -- If you want devicons
    "stevearc/resession.nvim", -- Optional, for persistent history
  },
  config = function()
    local hlgroups = require("cokeline.hlgroups")
    local hl_attr = hlgroups.get_hl_attr

    require("cokeline").setup({
      default_hl = {
        fg = function(buffer)
          return buffer.is_focused and hl_attr("Normal", "fg") or hl_attr("Comment", "fg")
        end,
        bg = hl_attr("ColorColumn", "bg"),
      },

      components = {
        {
          text = " ",
          bg = hl_attr("Normal", "bg"),
        },
        {
          text = "",
          fg = hl_attr("ColorColumn", "bg"),
          bg = hl_attr("Normal", "bg"),
        },
        {
          text = function(buffer)
            return buffer.devicon.icon
          end,
          fg = function(buffer)
            return buffer.devicon.color
          end,
        },
        {
          text = " ",
        },
        {
          text = function(buffer)
            return buffer.filename .. "  "
          end,
          style = function(buffer)
            return buffer.is_focused and "bold" or nil
          end,
          ft = "TabLine",
          bg = "TabLineFill",
        },
        {
          text = "x",
          delete_buffer_on_left_click = true,
        },
        {
          text = " ",
        },
        {
          text = "",
          fg = hl_attr("ColorColumn", "bg"),
          bg = hl_attr("Normal", "bg"),
        },
      },

      rhs = {

        {

          text = function()
            return " " .. os.date("%H:%M") .. " "
          end,

          fg = "TabLine",

          bg = "TabLineFill",
        },
      },
    })
  end,
}
