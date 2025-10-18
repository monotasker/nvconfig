-- Plugin: nvim-focus/focus.nvim
-- Installed via store.nvim

return {
  "nvim-focus/focus.nvim",
  event = "VeryLazy",
  config = function()
    require("focus").setup({
      enable = true, -- Enable module
      commands = true, -- Create Focus commands
      autoresize = {
        enable = true, -- Enable or disable auto-resizing of splits
        width = 0, -- Force width for the focused window
        height = 0, -- Force height for the focused window
        minwidth = 60, -- Force minimum width for the unfocused window
        minheight = 10, -- Force minimum height for the unfocused window
        focusedwindow_minwidth = 88, --Force minimum width for the focused window
        focusedwindow_minheight = 20, --Force minimum height for the focused window
        height_quickfix = 10, -- Set the height of quickfix panel
      },
      split = {
        bufnew = false, -- Create blank buffer for new split windows
        tmux = false, -- Create tmux splits instead of neovim splits
      },
      ui = {
        number = false, -- Display line numbers in the focussed window only
        relativenumber = false, -- Display relative line numbers in the focussed window only
        hybridnumber = false, -- Display hybrid line numbers in the focussed window only
        absolutenumber_unfocussed = false, -- Preserve absolute numbers in the unfocussed windows

        cursorline = true, -- Display a cursorline in the focussed window only
        cursorcolumn = false, -- Display cursorcolumn in the focussed window only
        colorcolumn = {
          enable = false, -- Display colorcolumn in the foccused window only
          list = "+1", -- Set the comma-saperated list for the colorcolumn
        },
        signcolumn = true, -- Display signcolumn in the focussed window only
        winhighlight = false, -- Auto highlighting for focussed/unfocussed windows
      },
    })
    -- Exclude Neotree and snacks explorer from focus.nvim resizing
    local ignore_filetypes = {
      "neo-tree",
      "neo-tree-popup",
      "neo-tree-filesystem",
      "neo-tree-buffers",
      "neo-tree-git_status",
      "neo-tree-diagnostics",
      "neo-tree-search",
    }
    local ignore_buftypes = { "nofile", "prompt", "popup" }

    local augroup = vim.api.nvim_create_augroup("FocusDisable", { clear = true })

    -- Disable for specific buffer types
    vim.api.nvim_create_autocmd("WinEnter", {
      group = augroup,
      callback = function()
        if vim.tbl_contains(ignore_buftypes, vim.bo.buftype) then
          vim.w.focus_disable = true
        else
          vim.w.focus_disable = false
        end
      end,
      desc = "Disable focus autoresize for BufType",
    })

    -- Disable for specific file types
    vim.api.nvim_create_autocmd("FileType", {
      group = augroup,
      callback = function()
        if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
          vim.b.focus_disable = true
        else
          vim.b.focus_disable = false
        end
      end,
      desc = "Disable focus autoresize for FileType",
    })
  end,
}
