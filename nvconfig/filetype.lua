vim.filetype.add({
  extension = {
    overrides = "less",
    cfg = "python",
  },
  pattern = {
    -- Detect Flask/Jinja templates in templates/ directories
    [".*/templates/.*%.html$"] = "jinja",
    [".*/template/.*%.html$"] = "jinja",
  },
})
