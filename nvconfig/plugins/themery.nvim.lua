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
        "gruvbox",
        "kanagawa-paper",
        "kanagawa-paper-canvas",
        "kanagawa-paper-ink",
        "material",
        "neofusion",
        "NeoSolarized",
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
        "solarized",
        "solarized-high",
        "sonokai",
        "tempus_day",
        "tempus_totus",
      },
      livePreview = true,
    })
  end,
}
