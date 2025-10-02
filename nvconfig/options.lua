-- core settings

vim.cmd("colorscheme dayfox")
vim.opt.guifont = "Monaspace Neon NF Regular:h15"
-- vim.opt.guifont = "JetBrainsMono Nerd Font Mono:h15"
-- vim.cmd("set bg=dark")

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.list = true
vim.opt.listchars = "eol:.,tab:>-,trail:~,extends:>,precedes:<"

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes:2"
vim.opt.scrolloff = 8
vim.opt.showcmd = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.config/nvim/undodir"
vim.opt.undofile = true
vim.opt.clipboard = "unnamed"

vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.termguicolors = true

vim.opt.showmode = false

-- Completion performance optimizations
vim.opt.completeopt = "menu,menuone,noinsert,noselect"
-- vim.opt.pumheight = 10 -- Limit popup menu height
-- vim.opt.pumwidth = 50 -- Limit popup menu width
-- vim.opt.shortmess:append('c') -- Don't show completion messages
vim.opt.updatetime = 300 -- Faster completion trigger
vim.opt.timeoutlen = 500 -- Faster key sequence timeout

-- Split behavior - equal widths only when starting sessions
vim.opt.equalalways = false

-- Equalize window widths when session is loaded
vim.api.nvim_create_autocmd("SessionLoadPost", {
  callback = function()
    vim.cmd("wincmd =")
  end,
})

-- No automatic comment insertion
vim.cmd([[autocmd FileType * set formatoptions-=ro]])

-- Auto-source config files on save
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "*.lua", "*.vim" },
  callback = function()
    -- Get the current file path
    local file = vim.fn.expand("%")

    if
      file:match("nvim/init%.lua")
      or file:match("nvim/lua/nvconfig/")
      or file:match("nvim/lua/nvconfig/packages/")
      or file:match("nvim/lua/")
    then
      vim.cmd("source " .. file)
      print("Sourced: " .. file)
    end
  end,
})

-- window management

-- Auto-resize active window to optimal width (max of total_width/buffer_count or 90) and minimum 20 lines tall
-- Only applies to regular editing buffers (excludes help, quickfix, terminal, etc.)
-- PERFORMANCE OPTIMIZED: Only runs on VimResized and BufWinEnter, not every WinEnter
vim.api.nvim_create_autocmd({ "VimResized", "BufWinEnter" }, {
  callback = function()
    local current_win = vim.api.nvim_get_current_win()
    local current_buf = vim.api.nvim_win_get_buf(current_win)
    local buf_type = vim.api.nvim_buf_get_option(current_buf, "buftype")
    local file_type = vim.api.nvim_buf_get_option(current_buf, "filetype")

    -- Skip non-editing buffers
    local skip_filetypes = {
      "help",
      "qf",
      "terminal",
      "telescope",
      "neo-tree",
      "trouble",
      "store",
      "outline",
      "aerial",
      "diffview",
      "neogit",
      "toggleterm",
    }

    if buf_type ~= "" or vim.tbl_contains(skip_filetypes, file_type) then
      return
    end

    -- Count editing windows (excluding skipped filetypes) - cached for performance
    local editing_windows = 0
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      local win_buf = vim.api.nvim_win_get_buf(win)
      local buf_buftype = vim.api.nvim_buf_get_option(win_buf, "buftype")
      local buf_filetype = vim.api.nvim_buf_get_option(win_buf, "filetype")
      if buf_buftype == "" and not vim.tbl_contains(skip_filetypes, buf_filetype) then
        editing_windows = editing_windows + 1
      end
    end

    -- Don't resize if there are no editing windows or if this is the only editing window
    if editing_windows <= 1 then
      return
    end

    -- Calculate optimal width: max of (total_width / window_count) or 90
    local total_width = vim.o.columns
    local optimal_width = math.max(math.floor(total_width / editing_windows), 90)

    local current_width = vim.api.nvim_win_get_width(current_win)
    local current_height = vim.api.nvim_win_get_height(current_win)

    -- Resize width if too narrow
    if current_width < optimal_width then
      vim.api.nvim_win_set_width(current_win, optimal_width)
    end

    -- Resize height if too short
    if current_height < 20 then
      vim.api.nvim_win_set_height(current_win, 20)
    end
  end,
})
