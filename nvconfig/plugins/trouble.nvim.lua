-- Plugin: folke/trouble.nvim
-- Installed via store.nvim

return {
    "folke/trouble.nvim",
    cmd = "Trouble",
    config = function()
        require("trouble").setup({
            -- your configuration comes here
        })
    end,
}