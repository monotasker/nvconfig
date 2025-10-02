-- Plugin: goolord/alpha-nvim
-- Installed via store.nvim

return {
  "goolord/alpha-nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("alpha").setup(require("alpha.themes.theta").config)
    local theme = require("alpha.themes.theta")
    -- available: devicons, mini, default is mini
    -- if provider not loaded and enabled is true, it will try to use another provider
    theme.file_icons.provider = "devicons"
    require("alpha").setup(theme.config)
  end,
}
