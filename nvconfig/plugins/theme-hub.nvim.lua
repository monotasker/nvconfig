-- Plugin: Erl-koenig/theme-hub.nvim
-- Installed via store.nvim

return {
    "erl-koenig/theme-hub.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim"
        -- Optional: for themes that use lush (will be notified if a theme requires it)
        -- "rktjmp/lush.nvim"
    },
    config = function()
        require("theme-hub").setup(
            {}
        )
    end
}