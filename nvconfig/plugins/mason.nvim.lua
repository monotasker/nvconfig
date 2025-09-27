-- Plugin: mason-org/mason.nvim
-- Installed via store.nvim

return {
    "mason-org/mason.nvim",
    config = function()
      require('mason').setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
          }
        }
      })

      -- Install additional tools for your tech stack
      local mason_registry = require('mason-registry')

      -- Python tools
      local python_tools = {
        "ruff",            -- Fast linter, formatter, and import sorter
        "mypy",            -- Type checker
        "bandit",          -- Security linter
      }

      -- JavaScript/TypeScript tools
      local js_tools = {
        "biome",           -- Fast linter and formatter
        -- "typescript",      -- TypeScript compiler
      }

      -- Web development tools
      local web_tools = {
        "prettier",        -- HTML/CSS/JSON formatter
        "djlint",          -- Django/Jinja2 formatter
        "htmlhint",        -- HTML linter
        "stylelint",       -- CSS linter
      }

      -- Database & Query tools
      local db_tools = {
        "sqlfluff",        -- SQL linter and formatter
        "sql-formatter",   -- SQL formatter
      }

      -- Infrastructure tools
      local infra_tools = {
        "hadolint",        -- Dockerfile linter
        "nginx-config-formatter", -- Nginx formatter
      }

      -- Testing tools
      local test_tools = {
        "eslint-lsp",      -- JavaScript linter and LSP server
      }

      -- General development tools
      local general_tools = {
        "stylua",          -- Lua formatter
        "shfmt",           -- Shell formatter
        "yamlfmt",         -- YAML formatter
        "xmlformatter",    -- XML formatter
        "markdownlint",    -- Markdown linter
        "write-good",      -- English prose linter
        "taplo",           -- TOML formatter and linter
        "pyproject-fmt",   -- Python pyproject.toml formatter
      }

      -- Install all tools
      local all_tools = {}
      for _, tool in ipairs(python_tools) do table.insert(all_tools, tool) end
      for _, tool in ipairs(js_tools) do table.insert(all_tools, tool) end
      for _, tool in ipairs(web_tools) do table.insert(all_tools, tool) end
      for _, tool in ipairs(db_tools) do table.insert(all_tools, tool) end
      for _, tool in ipairs(infra_tools) do table.insert(all_tools, tool) end
      for _, tool in ipairs(test_tools) do table.insert(all_tools, tool) end
      for _, tool in ipairs(general_tools) do table.insert(all_tools, tool) end

      -- Install tools that aren't already installed
      for _, tool in ipairs(all_tools) do
        if not mason_registry.is_installed(tool) then
          mason_registry.get_package(tool):install()
        end
      end
    end,
}
