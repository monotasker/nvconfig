-- For `plugins/markview.lua` users.
return {
  "OXY2DEV/markview.nvim",
  lazy = false,

  -- For blink.cmp's completion
  -- source
  -- dependencies = {
  --     "saghen/blink.cmp"
  opts = {
    preview = {
      filetypes = { "markdown", "codecompanion" },
      icon_provider = "devicons", -- "mini" or "devicons" or "internal"
    },
  },
}
