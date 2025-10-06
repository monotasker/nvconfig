-- neovim keymappings

-- NAVIGATION

-- Navigate between windows using Ctrl + direction keys
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to window below" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to window above" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to window on right" })

-- Resize windows by 3 lines/columns with Cmd + arrow keys
vim.keymap.set("n", "<D-Left>", "3<C-w><", { desc = "Decrease window width by 3" })
vim.keymap.set("n", "<D-Right>", "3<C-w>>", { desc = "Increase window width by 3" })
vim.keymap.set("n", "<D-Up>", "3<C-w>-", { desc = "Decrease window height by 3" })
vim.keymap.set("n", "<D-Down>", "3<C-w>+", { desc = "Increase window height by 3" })

-- Buffer navigation
vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<C-n>", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<C-p>", ":bprevious<CR>", { desc = "Previous buffer" })

-- EDITING

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move current line down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move current line up" })
vim.keymap.set(
  "n",
  "<leader>s",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "Find and replace current word" }
)

-- MISC

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlights text when yanking",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- PLUGINS

-- telescope

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
vim.keymap.set("n", "<leader>fp", "<cmd>Telescope neovim-project<cr>", { desc = "Find projects" })

-- neo-tree

vim.keymap.set("n", "<leader>t", "<Cmd>Neotree<CR>", { desc = "Open Neotree" })

-- Aerial.nvim

vim.keymap.set("n", "<leader>oa", "<Cmd>AerialToggle<CR>", { desc = "Toggle Aerial symbols view" })

-- outline.nvim

vim.keymap.set("n", "<leader>o", "<Cmd>Outline<CR>", { desc = "Toggle symbols outline" })

-- Comment.nvim

-- Toggle line comments with Ctrl+/
vim.keymap.set("n", "<C-/>", "<Plug>(comment_toggle_linewise_current)", { desc = "Toggle line comment" })
vim.keymap.set("v", "<C-/>", "<Plug>(comment_toggle_linewise_visual)", { desc = "Toggle line comment" })
vim.keymap.set("i", "<C-/>", "<Plug>(comment_toggle_linewise_current)", { desc = "Toggle line comment" })

-- Block comments
vim.keymap.set("n", "<leader>bc", "<Plug>(comment_toggle_blockwise_current)", { desc = "Toggle block comment" })
vim.keymap.set("v", "<leader>bc", "<Plug>(comment_toggle_blockwise_visual)", { desc = "Toggle block comment" })

-- LSP KEYBINDINGS

-- LSP navigation and actions
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", { desc = "Go to references" })
-- vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show hover documentation" })
vim.keymap.set("n", "<C-s>", vim.lsp.buf.signature_help, { desc = "Show signature help" })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostics" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })

-- COMPLETION KEYBINDINGS

-- nvim-cmp completion navigation
-- vim.keymap.set("i", "<Tab>", function()
--   if require("cmp").visible() then
--     require("cmp").select_next_item()
--   else
--     -- Just insert a tab - never trigger completion
--     vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
--   end
-- end, { desc = "Next completion item or insert tab" })
-- vim.keymap.set("i", "<S-Tab>", function()
--   if require("cmp").visible() then
--     require("cmp").select_prev_item()
--   end
-- end, { desc = "Previous completion item" })
-- vim.keymap.set("i", "<leader>c", function()
--   require("cmp").complete()
-- end, { desc = "Trigger completion" })
-- vim.keymap.set("i", "<CR>", function()
--   if require("cmp").visible() and require("cmp").get_selected_entry() then
--     require("cmp").confirm({ select = true })
--   else
--     -- Normal Enter behavior
--     vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, false, true), "n", false)
--   end
-- end, { desc = "Confirm completion or newline" })
-- vim.keymap.set("i", "<Esc>", function()
--   if require("cmp").visible() then
--     require("cmp").abort()
--   else
--     vim.cmd("stopinsert")
--   end
-- end, { desc = "Dismiss completion or exit insert mode" })

-- FORMATTING KEYBINDINGS

-- Manual formatting
vim.keymap.set({ "n", "v" }, "<leader>mp", function()
  require("conform").format({
    lsp_fallback = true,
    async = false,
    timeout_ms = 1000,
  })
end, { desc = "Format file or range" })

-- LINTING KEYBINDINGS

-- Manual linting
vim.keymap.set("n", "<leader>ml", function()
  require("lint").try_lint()
end, { desc = "Trigger linting" })

-- TROUBLE KEYBINDINGS

-- Trouble diagnostics and lists
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Toggle Trouble diagnostics" })
vim.keymap.set(
  "n",
  "<leader>xw",
  "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
  { desc = "Show workspace diagnostics" }
)
vim.keymap.set(
  "n",
  "<leader>xd",
  "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
  { desc = "Show document diagnostics" }
)
vim.keymap.set("n", "<leader>xl", "<cmd>Trouble loclist toggle<cr>", { desc = "Show location list" })
vim.keymap.set("n", "<leader>xq", "<cmd>Trouble qflist toggle<cr>", { desc = "Show quickfix list" })

-- UTILITY KEYBINDINGS

-- Show current file path
vim.keymap.set("n", "<leader>p", function()
  print(vim.fn.expand("%:p"))
end, { desc = "Show current file path" })

-- Sort imports with Ruff
vim.keymap.set("n", "<leader>si", function()
  local filename = vim.fn.expand("%")
  if vim.bo.filetype == "python" then
    vim.cmd("!ruff check --fix --select I " .. filename)
    vim.cmd("edit")
  else
    print("Not a Python file")
  end
end, { desc = "Sort imports with Ruff" })

-- UFO FOLDING KEYBINDINGS

-- Basic UFO fold commands
vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "Open all folds" })
vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "Close all folds" })
vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds, { desc = "Open folds except kinds" })
vim.keymap.set("n", "zm", require("ufo").closeFoldsWith, { desc = "Close folds with" })
vim.keymap.set("n", "zK", require("ufo").peekFoldedLinesUnderCursor, { desc = "Peek folded lines under cursor" })

-- Standard Vim fold commands
vim.keymap.set("n", "za", "za", { desc = "Toggle fold under cursor" })
vim.keymap.set("n", "zo", "zo", { desc = "Open fold under cursor" })
vim.keymap.set("n", "zc", "zc", { desc = "Close fold under cursor" })
vim.keymap.set("n", "zO", "zO", { desc = "Open all folds recursively" })
vim.keymap.set("n", "zC", "zC", { desc = "Close all folds recursively" })

-- Fold level commands (0-9)
for i = 0, 9 do
  vim.keymap.set("n", "z" .. i, function()
    vim.cmd("set foldlevel=" .. i)
  end, { desc = "Set fold level to " .. i })
end

-- Visual mode fold commands
vim.keymap.set("v", "zf", "zf", { desc = "Create fold from selection" })
vim.keymap.set("n", "zd", "zd", { desc = "Delete fold under cursor" })
vim.keymap.set("n", "zD", "zD", { desc = "Delete all folds" })
vim.keymap.set("n", "zj", "zj", { desc = "Move to next fold" })
vim.keymap.set("n", "zk", "zk", { desc = "Move to previous fold" })
