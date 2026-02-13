-- Plugin: stevearc/conform.nvim
-- Installed via store.nvim

return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        -- Python
        python = { "ruff_format" },

        -- JavaScript/TypeScript/React
        javascript = { "biome" },
        typescript = { "biome" },
        javascriptreact = { "biome" },
        typescriptreact = { "biome" },

        -- Web technologies
        -- html = { "prettier" }, -- Disabled: prettier doesn't handle Jinja syntax well
        htmldjango = { "djlint" }, -- Removed prettier to avoid conflicts with Jinja
        jinja = { "djlint" },
        jinja2 = { "djlint" },
        css = { "prettier" },
        less = { "prettier" },
        scss = { "prettier" },
        sass = { "prettier" },

        -- Data formats
        json = { "prettier" },
        yaml = { "yamlfmt" },
        yml = { "yamlfmt" },
        toml = { "pyproject-fmt", "taplo" }, -- Try pyproject-fmt first, fallback to taplo
        xml = { "xmlformatter" },

        -- Config files
        dotenv = { "trim_whitespace" },

        -- Markup
        markdown = { "prettier" },
        mdx = { "prettier" },

        -- Database & Query
        sql = { "sql-formatter" },

        -- Infrastructure
        dockerfile = { "hadolint" },
        nginx = { "nginxfmt", "prettier" },

        -- Config files
        lua = { "stylua" },
        sh = { "shfmt" },
        bash = { "shfmt" },
        zsh = { "shfmt" },
      },

      -- Use a function so we can skip format-on-save per project/path
      format_on_save = function(bufnr)
        local path = vim.api.nvim_buf_get_name(bufnr)
        if path == "" then
          return { timeout_ms = 1000, lsp_fallback = true }
        end
        -- Paths (or path segments) where format-on-save is disabled
        local no_format_paths = {
          "specifications", -- this repo: preserve manual markdown layout
        }
        for _, segment in ipairs(no_format_paths) do
          if path:find(segment, 1, true) then
            return nil -- skip formatting in this buffer
          end
        end
        return { timeout_ms = 1000, lsp_fallback = true }
      end,

      formatters = {
        -- Python
        ruff_format = {
          command = "ruff",
          args = {
            "format",
            "--stdin-filename",
            "$FILENAME",
            "--line-length",
            "88",
            "--target-version",
            "py312",
            "--preview", -- Enable Black-compatible formatting
            "-",
          },
        },

        -- JavaScript/TypeScript: match Prettier/ESLint so output is interchangeable
        biome = {
          command = "biome",
          args = { "format", "--stdin-file-path", "$FILENAME", "-" },
          prepend_args = {
            "--indent-style=space",
            "--indent-width=2",
            "--line-width=100",
            "--semicolons=always",
            "--javascript-formatter-quote-style=double",
            "--trailing-commas=es5",
          },
        },

        -- Web technologies
        djlint = {
          prepend_args = { "--reformat", "--indent", "2" },
        },

        -- Data formats
        yamlfmt = {
          prepend_args = { "-formatter", "indent=2" },
        },
        xmlformatter = {
          prepend_args = { "--indent", "2" },
        },

        -- Database & Query
        ["sql-formatter"] = {
          command = "sql-formatter",
          args = { "--language", "postgresql" },
        },

        -- Infrastructure
        hadolint = {
          command = "hadolint",
          args = { "--format", "json", "-" },
        },
        nginxfmt = {
          command = "nginxfmt",
          args = { "-i", "2" },
        },

        -- Config files
        stylua = {
          prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" },
        },
        shfmt = {
          prepend_args = { "-i", "2" },
        },
        taplo = {
          command = "taplo",
          args = { "format", "--stdin-filepath", "$FILENAME", "-" },
        },
        ["pyproject-fmt"] = {
          command = "pyproject-fmt",
          args = { "-" },
        },
        trim_whitespace = {
          command = "sed",
          args = { "s/[[:space:]]*$//" },
        },
      },
    })

    -- Manual format keymap is now centralized in remap.lua
  end,
}
