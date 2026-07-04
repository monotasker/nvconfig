return {
  "vpoltora/cursor-light.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("cursor-light").setup()
  end,
}
