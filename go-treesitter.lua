-- Go Tree-sitter setup for Neovim
-- This module configures Tree-sitter for Go language support

local M = {}

function M.setup()
    -- Ensure tree-sitter is installed
    require('nvim-treesitter.configs').setup({
        ensure_installed = {
            'go',
        },
        
        -- Enable highlight
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
        
        -- Enable indentation
        indent = {
            enable = true,
        },
        
        -- Enable incremental selection
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = 'gnn',
                node_incremental = 'grn',
                scope_incremental = 'grc',
                node_decremental = 'grm',
            },
        },
        
        -- Enable code lenses (if you use nvim-lua/lsp-signature)
    })
end

return M
