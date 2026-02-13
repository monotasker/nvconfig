-- Plugin: numToStr/Comment.nvim
-- Installed via store.nvim

return {
    "numToStr/Comment.nvim",
    opts = {
        -- Enable keybindings (they're set up in remap.lua)
        toggler = {
            line = "gcc",  -- Toggle current line
            block = "gbc", -- Toggle current block
        },
        opleader = {
            line = "gc",  -- Comment out lines
            block = "gb", -- Comment out blocks
        },
        -- Configure filetype-specific comment strings
        pre_hook = function(ctx)
            local U = require("Comment.utils")
            -- Enable triple-quote block comments for Python
            if vim.bo.filetype == "python" then
                if ctx.ctype == U.ctype.block then
                    -- For block comments, use triple quotes
                    return { commentstring = '"""%s"""' }
                end
            end
        end,
    },
    lazy = false, -- Load immediately to ensure <Plug> mappings are available
    config = function(_, opts)
        require("Comment").setup(opts)
    end,
}