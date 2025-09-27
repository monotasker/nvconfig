-- lazy.vim package management settings

local lazypath = vim.fn.stdpath("data") .. "/plugins/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { import = "nvconfig.plugins.store" },
    { import = "nvconfig.plugins" },
  },
  defaults = {
    lazy = false,
    version = false,
  },
  checker = { enabled = true },
  change_detection = { notify = false },
})
