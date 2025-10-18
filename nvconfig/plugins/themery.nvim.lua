-- Plugin: zaldih/themery.nvim
-- Installed via store.nvim

return {
  "zaldih/themery.nvim",
  lazy = false,
  config = function()
    require("themery").setup({
      themes = {
        "adwaita",
        "catppuccin",
        "dawnfox",
        "dayfox",
        "duskfox",
        "edge",
        "kanagawa-paper-canvas",
        "kanagawa-paper-ink",
        "material",
        "nightfox",
        "nord",
        "nordfox",
        "onedark",
        "onehalfdark",
        "onehalflight",
        "onelight",
        "onenord",
        "onenord-light",
        "rusticated",
        "sonokai",
        "tempus_day",
        "tempus_totus",
      },
      livePreview = true,
    })
  end,
}
