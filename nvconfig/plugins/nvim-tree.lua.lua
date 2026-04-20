-- Plugin: nvim-tree/nvim-tree.lua
-- Installed via store.nvim

return {
  "nvim-tree/nvim-tree.lua",
  event = "VeryLazy",
  config = function()
    require("nvim-tree").setup({})
  end,
}

