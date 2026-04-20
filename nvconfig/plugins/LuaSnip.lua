-- Plugin: L3MON4D3/LuaSnip
-- Installed via store.nvim

return {
  "L3MON4D3/LuaSnip",
  -- follow latest release.
  version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
  -- install jsregexp (optional!).
  build = "make install_jsregexp",
  config = function()
    local ls = require("luasnip")
    local lua_loader = require("luasnip.loaders.from_lua")
    local snippets_path = vim.fn.stdpath("config") .. "/lua/nvconfig/snippets"

    ls.config.set_config({
      history = true,
      updateevents = "TextChanged,TextChangedI",
    })

    lua_loader.lazy_load({
      paths = { snippets_path },
    })

    ls.filetype_extend("javascriptreact", { "javascript" })
    ls.filetype_extend("typescript", { "javascript" })
    ls.filetype_extend("typescriptreact", { "javascript" })

    -- Handy while iterating on custom snippets.
    pcall(vim.api.nvim_del_user_command, "LuaSnipReload")
    vim.api.nvim_create_user_command("LuaSnipReload", function()
      lua_loader.load({
        paths = { snippets_path },
      })
    end, { desc = "Reload LuaSnip snippets from config path" })
  end,
}
