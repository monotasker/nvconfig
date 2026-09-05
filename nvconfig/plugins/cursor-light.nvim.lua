return {
  "vpoltora/cursor-light.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    -- ui=false: skip cursor-light's statuscolumn (and its other UI overrides)
    -- so Snacks.statuscolumn can own the gutter.
    require("cursor-light").setup({ ui = false })
  end,
}
