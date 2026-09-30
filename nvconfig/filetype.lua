vim.filetype.add({
  extension = {
    overrides = "less",
    cfg = "python",
  },
  pattern = {
    -- Detect Flask/Jinja templates in templates/ directories
    [".*/templates/.*%.html$"] = "jinja",
    [".*/template/.*%.html$"] = "jinja",
    -- JSX-in-.js (React) without renaming every .js file
    [".*%.js"] = function(_, bufnr)
      local lines = vim.api.nvim_buf_get_lines(bufnr, 0, 80, false)
      local sample = table.concat(lines, "\n")
      if
        sample:find("from%s+[\"']react[\"']")
        or sample:find("require%s*%(%s*[\"']react[\"']")
      then
        return "javascriptreact"
      end
    end,
  },
})
