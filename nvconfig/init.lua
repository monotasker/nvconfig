-- Set leader key before lazy.nvim loads
vim.g.node_path = os.getenv("NVM_DIR") .. "/versions/node/v24.9.0/bin/node"

vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

require("nvconfig.lazy_init")
require("nvconfig.options")
require("nvconfig.remap")
require("nvconfig.filetype")
