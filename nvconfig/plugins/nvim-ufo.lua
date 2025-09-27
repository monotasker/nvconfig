-- Plugin: kevinhwang91/nvim-ufo
-- Installed via store.nvim

return {
  "kevinhwang91/nvim-ufo",
  dependencies = "kevinhwang91/promise-async",
  event = "VeryLazy",
  config = function()
    -- Set essential Vim options for folding
    vim.o.foldcolumn = '0'
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true

    -- Configure LSP capabilities for folding
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true
    }

    -- Apply capabilities to all LSP clients
    local language_servers = vim.lsp.get_clients()
    for _, ls in ipairs(language_servers) do
      require('lspconfig')[ls].setup({
        capabilities = capabilities
      })
    end

    -- Setup ufo with LSP provider
    require('ufo').setup()

    -- Set fold options AFTER ufo setup to override any ufo defaults
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
  end,
}

