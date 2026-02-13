-- Plugin: mfussenegger/nvim-lint
-- Installed via store.nvim

return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      -- Python
      python = { "ruff", "mypy", "bandit" },

      -- JavaScript/TypeScript/React
      javascript = { "biome" },
      typescript = { "biome" },
      javascriptreact = { "biome" },
      typescriptreact = { "biome" },

      -- Web technologies
      html = { "htmlhint" },
      css = { "stylelint" },
      less = { "stylelint" },
      scss = { "stylelint" },
      sass = { "stylelint" },

      -- Markup
      markdown = { "markdownlint" },
      mdx = { "markdownlint" },

      -- Config files
      lua = { "luacheck" },
      yaml = { "yamllint" },
      yml = { "yamllint" },
      toml = { "pyproject-fmt", "taplo" },
      dotenv = { "trim_whitespace" },

      -- Data formats

      -- Database & Query
      sql = { "sqlfluff" },

      -- Infrastructure
      dockerfile = { "hadolint" },
      nginx = { "nginx-config-formatter" },

      -- Templating
      jinja = { "djlint" },
      jinja2 = { "djlint" },
      django = { "djlint" },
    }

    -- Configure ruff linter to include formatting rules
    lint.linters.ruff = {
      cmd = "ruff",
      args = {
        "check",
        "--stdin-filename",
        "$FILENAME",
        "--line-length",
        "88",
        "--target-version",
        "py312",
        "--select",
        "E,F,I,B,UP,D,DOC,Q,COM,ISC", -- Include formatting rules
        "--ignore",
        "D104,D412", -- Ignore missing docstring in __init__
        "-",
      },
      stdin = true,
      stream = "stderr",
      ignore_exitcode = true,
    }

    -- Configure biome linter
    lint.linters.biome = {
      cmd = "biome",
      args = {
        "check",
        "--stdin-file-path",
        "$FILENAME",
        "-",
      },
      stdin = true,
      stream = "stderr",
      ignore_exitcode = true,
    }

    -- Customize bandit to ignore assert warnings
    lint.linters.bandit.args = {
      "--skip",
      "B101", -- Skip assert statement warnings
    }

    -- Configure mypy linter
    lint.linters.mypy.args = {
      "--config-file",
      "pyproject.toml",
      "--show-error-codes",
      "--no-error-summary",
      "--ignore-missing-imports",
      "$FILENAME",
    }

    -- Configure sqlfluff linter
    lint.linters.sqlfluff = {
      cmd = "sqlfluff",
      args = {
        "lint",
        "--dialect",
        "postgres",
        "--format",
        "json",
        "--stdin-filename",
        "$FILENAME",
        "-",
      },
      stdin = true,
      stream = "stderr",
      ignore_exitcode = true,
    }

    -- Configure hadolint linter
    lint.linters.hadolint = {
      cmd = "hadolint",
      args = {
        "--format",
        "json",
        "--stdin-filename",
        "$FILENAME",
        "-",
      },
      stdin = true,
      stream = "stderr",
      ignore_exitcode = true,
    }

    -- Configure nginx linter
    lint.linters.nginx = {
      cmd = "nginx",
      args = { "-t", "-c", "$FILENAME" },
      stdin = false,
      stream = "stderr",
      ignore_exitcode = true,
    }

    -- Configure taplo linter
    lint.linters.taplo = {
      cmd = "taplo",
      args = {
        "lint",
        "--stdin-filepath",
        "$FILENAME",
        "-",
      },
      stdin = true,
      stream = "stderr",
      ignore_exitcode = true,
    }

    -- Configure pyproject-fmt linter
    lint.linters["pyproject-fmt"] = {
      cmd = "pyproject-fmt",
      args = {
        "--check",
        "--stdin-filename",
        "$FILENAME",
        "-",
      },
      stdin = true,
      stream = "stderr",
      ignore_exitcode = true,
    }

    -- Configure trim_whitespace linter
    lint.linters.trim_whitespace = {
      cmd = "sed",
      args = { "-n", "s/[[:space:]]*$//p" },
      stdin = true,
      stream = "stderr",
      ignore_exitcode = true,
    }

    -- Auto-lint
    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        -- Don't lint huge files
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(0))
        if ok and stats and stats.size > max_filesize then
          return
        end

        lint.try_lint()
      end,
    })

    -- Manual lint keymap is now centralized in remap.lua
  end,
}
