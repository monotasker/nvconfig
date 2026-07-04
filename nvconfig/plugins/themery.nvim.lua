-- Plugin: zaldih/themery.nvim
-- Installed via store.nvim

return {
  "zaldih/themery.nvim",
  lazy = false,
  dependencies = {
    "erl-koenig/theme-hub.nvim",
  },
  config = function()
    ---@param name string Display name in the Themery menu
    ---@param colorscheme string Colorscheme to apply
    ---@param background "dark"|"light"
    ---@return table
    local function theme(name, colorscheme, background)
      return {
        name = name,
        colorscheme = colorscheme,
        before = string.format('vim.opt.background = "%s"', background),
      }
    end

    require("themery").setup({
      themes = {
        -- Background-aware themes (dark / light pairs)
        theme("adwaita-dark", "adwaita", "dark"),
        theme("adwaita-light", "adwaita", "light"),
        theme("catppuccin-dark", "catppuccin", "dark"),
        theme("catppuccin-light", "catppuccin", "light"),
        theme("edge-dark", "edge", "dark"),
        theme("edge-light", "edge", "light"),
        theme("gruvbox-material-dark", "gruvbox-material", "dark"),
        theme("gruvbox-material-light", "gruvbox-material", "light"),
        theme("material-dark", "material", "dark"),
        theme("material-light", "material", "light"),
        theme("onenord-dark", "onenord", "dark"),

        -- Fixed-variant themes (explicit background for persistence)
        theme("cursor-light", "cursor-light", "light"),
        theme("kanagawa-paper-canvas", "kanagawa-paper-canvas", "light"),
        theme("kanagawa-paper-ink", "kanagawa-paper-ink", "dark"),
        theme("nord", "nord", "dark"),
        theme("onedark", "onedark", "dark"),
        theme("onenord-light", "onenord-light", "light"),
        theme("sonokai", "sonokai", "dark"),
      },
      livePreview = true,
      -- Refresh highlights after colorscheme is applied to fix plugin overrides
      globalAfter = [[
        vim.cmd("doautocmd ColorScheme")
      ]],
    })
  end,
}
