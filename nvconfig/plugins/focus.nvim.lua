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
        minwidth = 70, -- Force minimum width for the unfocused window
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
        number = true, -- Display line numbers in the focussed window only
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
        winhighlight = true, -- Auto highlighting for focussed/unfocussed windows
      },
    })

    -- focus.nvim defaults FocusedWindow → VertSplit (dim border grey), which
    -- makes all Normal text in the focused window unreadable. Override with
    -- theme-derived highlights; re-apply on ColorScheme after highlight clear.
    ---@param color integer|nil 24-bit RGB from nvim_get_hl
    ---@param factor number Scale channels toward black (e.g. 0.85)
    ---@return integer|nil
    local function dim_color(color, factor)
      if not color then
        return nil
      end
      local r = math.floor(color / 65536) % 256
      local g = math.floor(color / 256) % 256
      local b = color % 256
      r = math.floor(r * factor)
      g = math.floor(g * factor)
      b = math.floor(b * factor)
      return (r * 65536) + (g * 256) + b
    end

    local function set_focus_win_highlights()
      vim.api.nvim_set_hl(0, "FocusedWindow", { link = "Normal" })

      local normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
      local comment = vim.api.nvim_get_hl(0, { name = "Comment", link = false })
      local dim_bg = dim_color(normal.bg, 0.85)

      if dim_bg then
        vim.api.nvim_set_hl(0, "UnfocusedWindow", {
          fg = comment.fg or normal.fg,
          bg = dim_bg,
        })
      else
        -- Transparent Normal bg: fall back to NormalNC / Comment.
        vim.api.nvim_set_hl(0, "UnfocusedWindow", { link = "NormalNC" })
      end
    end
    set_focus_win_highlights()
    vim.api.nvim_create_autocmd("ColorScheme", {
      group = vim.api.nvim_create_augroup("FocusWinHighlights", { clear = true }),
      callback = set_focus_win_highlights,
      desc = "Keep focus.nvim window highlights readable after colorscheme",
    })

    -- Exclude sidebars/panels from focus.nvim resizing
    local ignore_filetypes = {
      "neo-tree",
      "neo-tree-popup",
      "neo-tree-filesystem",
      "neo-tree-buffers",
      "neo-tree-git_status",
      "neo-tree-diagnostics",
      "neo-tree-search",
      -- Avante chat sidebar (result / selected files / input)
      "Avante",
      "AvanteInput",
      "AvanteSelectedFiles",
      "AvanteSelectedCode",
      "AvanteTodos",
      "AvanteConfirm",
      "AvantePromptInput",
    }
    local ignore_buftypes = { "nofile", "prompt", "popup" }

    local augroup = vim.api.nvim_create_augroup("FocusDisable", { clear = true })

    local function should_disable_focus()
      return vim.tbl_contains(ignore_buftypes, vim.bo.buftype)
        or vim.tbl_contains(ignore_filetypes, vim.bo.filetype)
    end

    -- Disable for specific buffer/file types (window-scoped on enter)
    vim.api.nvim_create_autocmd("WinEnter", {
      group = augroup,
      callback = function()
        vim.w.focus_disable = should_disable_focus()
      end,
      desc = "Disable focus autoresize for BufType/FileType",
    })

    -- Disable for specific file types (buffer-scoped; survives focus in other wins)
    vim.api.nvim_create_autocmd("FileType", {
      group = augroup,
      callback = function()
        vim.b.focus_disable = vim.tbl_contains(ignore_filetypes, vim.bo.filetype)
      end,
      desc = "Disable focus autoresize for FileType",
    })
  end,
}
