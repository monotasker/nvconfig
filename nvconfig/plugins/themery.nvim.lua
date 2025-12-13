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
        "cursor-light",
        "dawnfox",
        "dayfox",
        "duskfox",
        "edge",
        "kanagawa-paper-canvas",
        "kanagawa-paper-ink",
        "material",
        "nightfox",
        "nord",
        {
          name = "nordfox",
          colorscheme = "nordfox",
          before = [[
            vim.opt.background = "dark"
          ]],
        },
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
      -- Refresh highlights after colorscheme is applied to fix plugin overrides
      globalAfter = [[
        vim.cmd("doautocmd ColorScheme")
      ]],
    })
  end,
}
