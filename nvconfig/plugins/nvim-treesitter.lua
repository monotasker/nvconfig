-- Plugin: nvim-treesitter/nvim-treesitter (main branch)
-- See: https://github.com/nvim-treesitter/nvim-treesitter/tree/main
--
-- Migration notes (from master branch):
--   * `require('nvim-treesitter.configs').setup{...}` is gone.
--   * `ensure_installed`, `auto_install`, and the `highlight`/`indent`/
--     `incremental_selection` modules don't exist here.
--   * Parsers are installed explicitly via `require('nvim-treesitter').install`.
--   * Highlights are enabled per-buffer with `vim.treesitter.start()`.

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  -- No `build` hook: on the `main` branch, parser installation is handled by
  -- `require('nvim-treesitter').install` in `config` below. Running `:TSUpdate`
  -- as a build hook can fire before the new install module is re-required and
  -- end up running the stale (master-era) installer, which fails with errors
  -- like `mv tree-sitter-<lang>-tmp/<lang>-master ...`.
  config = function()
    -- The `main` branch installs parsers and queries to
    -- `<stdpath('data')>/site/{parser,queries}`. Lazy.nvim doesn't include this
    -- directory in `runtimepath` automatically, so Neovim cannot find the
    -- compiled `.so` files or the per-language query overrides without this.
    vim.opt.runtimepath:prepend(vim.fn.stdpath("data") .. "/site")

    local parsers = {
      "lua",
      "vim",
      "vimdoc",
      "query",

      "javascript",
      "typescript",
      "tsx",

      "html",
      "css",
      "scss",

      "json",
      "yaml",
      "toml",
      "xml",

      "markdown",
      "markdown_inline",
      "rst",
      "latex",

      "python",

      "sql",

      "dockerfile",
      "nginx",

      "bash",
      "gitignore",
      "gitattributes",

      -- Used by rest.nvim; install here so rest.nvim's dep no longer needs to
      -- mutate `opts.ensure_installed` (which doesn't exist on the main branch).
      "http",
    }

    local ok, ts = pcall(require, "nvim-treesitter")
    if ok and ts.install then
      ts.install(parsers)
    end

    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("nvconfig-treesitter-start", { clear = true }),
      callback = function(args)
        local buf = args.buf
        if not vim.api.nvim_buf_is_valid(buf) then
          return
        end
        local ft = vim.bo[buf].filetype
        if ft == "" then
          return
        end
        local lang = vim.treesitter.language.get_lang(ft) or ft
        local started = pcall(vim.treesitter.start, buf, lang)
        if started then
          vim.bo[buf].syntax = "ON"
        end
      end,
    })
  end,
}
