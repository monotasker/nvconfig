-- Plugin: mason-org/mason-lspconfig.nvim
-- Installed via store.nvim

return {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "mason-org/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          -- Python
          "pylsp",

          -- JavaScript/TypeScript/React
          "ts_ls",
          "biome",  -- INVALID: This is a linter/formatter, not an LSP server

          -- Web technologies
          "html",
          "cssls",  -- TESTING: Commented out for now
          "jsonls",  -- TESTING: Commented out for now
          "emmet_ls",  -- TESTING: Commented out for now

          -- Data formats
          "yamlls",  -- TESTING: Commented out for now
          "lemminx",  -- TESTING: Commented out for now (XML language server)

          -- Markup
          "marksman",  -- TESTING: Commented out for now (Markdown language server)

          -- Database & Query
          "sqls",  -- TESTING: Commented out for now (SQL language server)

          -- Infrastructure
          "dockerls",  -- TESTING: Commented out for now (Docker language server)
          "nginx_language_server",  -- Nginx language server

          -- Testing
          -- "quick_lint_js",  -- INVALID: This is a linter, not an LSP server

          -- General purpose
          "lua_ls",
        },
        automatic_installation = true,
      })
    end,
}