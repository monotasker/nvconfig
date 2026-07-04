-- Plugin: rest-nvim/rest.nvim
-- Installed via store.nvim
--
-- The "http" tree-sitter parser is installed by nvim-treesitter.lua. On the
-- nvim-treesitter `main` branch, dependencies can no longer add parsers via
-- `opts.ensure_installed`, so we just declare the dep here.

return {
    "rest-nvim/rest.nvim",
    build = false,
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
    },
}
