-- Plugin: nvim-treesitter/nvim-treesitter
-- Installed via store.nvim

return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        require('nvim-treesitter.configs').setup({
            ensure_installed = {
                -- Core Neovim
                "lua",
                "vim",
                "vimdoc",
                "query",

                -- JavaScript/TypeScript/React
                "javascript",
                "typescript",
                "tsx",

                -- Web technologies
                "html",
                "css",
                "scss",

                -- Data formats
                "json",
                "yaml",
                "toml",
                "xml",

                -- Markup
                "markdown",
                "markdown_inline",
                "rst",

                -- Python
                "python",

                -- Database & Query
                "sql",

                -- Infrastructure
                "dockerfile",
                "nginx",

                -- Config files
                "bash",
                "gitignore",
                "gitattributes",
            },
            sync_install = false,
            auto_install = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
        })
    end,
}