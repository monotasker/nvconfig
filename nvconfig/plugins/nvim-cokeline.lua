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
    require("cokeline").setup({
      default_hl = {
        fg = function(buffer)
          return buffer.is_focused and "TabLineSel" or "TabLine"
        end,
        bg = function(buffer)
          return buffer.is_focused and "TabLineSel" or "TabLine"
        end,
      },
      components = {
        {
          -- text = "",
          text = "",
          fg = function(buffer)
            return buffer.is_focused and "TabLineSel" or "TabLineFill"
          end,
          bg = "TabLineFill",
        },
        {
          text = function(buffer)
            return buffer.devicon.icon .. " "
          end,
          fg = function(buffer)
            return buffer.devicon.color
          end,
        },
        {
          text = function(buffer)
            return buffer.unique_prefix .. buffer.filename .. " "
          end,
          fg = function(buffer)
            return buffer.is_focused and "TabLineSel" or "TabLineFill"
          end,
        },
        {
          text = "",
          fg = function(buffer)
            return buffer.is_focused and "TabLineSel" or "TabLineFill"
          end,
          bg = "TabLineFill",
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
