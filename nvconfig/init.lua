
-- Set leader key before lazy.nvim loads
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("nvconfig.lazy_init")
require("nvconfig.options")
require("nvconfig.remap")
require("nvconfig.plugins")
