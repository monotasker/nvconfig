-- Plugin: akinsho/toggleterm.nvim
-- Installed via store.nvim

return {
  "akinsho/toggleterm.nvim",
  opts = {
    open_mapping = [[<leader>t]],
    terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
    persist_size = true,
    direction = "horizontal", -- "vertical" | "horizontal" | "tab" | "float",
  },
  event = "VeryLazy",
}
