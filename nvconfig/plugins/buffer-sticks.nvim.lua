-- Plugin: ahkohd/buffer-sticks.nvim
-- Installed via store.nvim

return {
    "ahkohd/buffer-sticks.nvim",
    config = function()
        require(
            "buffer-sticks"
        ).setup()
    end
}