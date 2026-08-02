-- Set leader key before lazy.nvim loads
vim.g.node_path = os.getenv("NVM_DIR") .. "/versions/node/v24.9.0/bin/node"

vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

-- Must be set before Themery/lazy loads the colorscheme, otherwise GUI
-- highlights are skipped on first paint.
vim.opt.termguicolors = true

require("nvconfig.lazy_init")
require("nvconfig.options")
require("nvconfig.remap")
require("nvconfig.filetype")
