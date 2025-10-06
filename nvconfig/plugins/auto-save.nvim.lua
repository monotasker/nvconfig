-- Plugin: pocco81/auto-save.nvim
-- Installed via store.nvim

return {
    "Pocco81/auto-save.nvim",
    enabled = false,  -- Disable autosave
    config = function()
        require("auto-save").setup {}
    end,
    event = "VeryLazy"
}