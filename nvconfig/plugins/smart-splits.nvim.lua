-- Plugin: mrjones2014/smart-splits.nvim
-- Installed via store.nvim

return {
    "mrjones2014/smart-splits.nvim",
    event = "VeryLazy",
    dependencies = {
        "pogyomo/submode.nvim"
    },
    config = function()
        -- Resize
        local submode =
            require "submode"
        submode.create(
            "WinResize",
            {
                mode = "n",
                enter = "<C-w>r",
                leave = {
                    "<Esc>",
                    "q",
                    "<C-c>"
                },
                hook = {
                    on_enter = function()
                        vim.notify "Use { h, j, k, l } or { <Left>, <Down>, <Up>, <Right> } to resize the window"
                    end,
                    on_leave = function()
                        vim.notify ""
                    end
                },
                default = function(
                    register)
                    register(
                        "h",
                        require(
                            "smart-splits"
                        ).resize_left,
                        {
                            desc = "Resize left"
                        }
                    )
                    register(
                        "j",
                        require(
                            "smart-splits"
                        ).resize_down,
                        {
                            desc = "Resize down"
                        }
                    )
                    register(
                        "k",
                        require(
                            "smart-splits"
                        ).resize_up,
                        {
                            desc = "Resize up"
                        }
                    )
                    register(
                        "l",
                        require(
                            "smart-splits"
                        ).resize_right,
                        {
                            desc = "Resize right"
                        }
                    )
                    register(
                        "<Left>",
                        require(
                            "smart-splits"
                        ).resize_left,
                        {
                            desc = "Resize left"
                        }
                    )
                    register(
                        "<Down>",
                        require(
                            "smart-splits"
                        ).resize_down,
                        {
                            desc = "Resize down"
                        }
                    )
                    register(
                        "<Up>",
                        require(
                            "smart-splits"
                        ).resize_up,
                        {
                            desc = "Resize up"
                        }
                    )
                    register(
                        "<Right>",
                        require(
                            "smart-splits"
                        ).resize_right,
                        {
                            desc = "Resize right"
                        }
                    )
                end
            }
        )
    end
}