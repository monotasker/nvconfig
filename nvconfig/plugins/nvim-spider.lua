-- Plugin: chrisgrieser/nvim-spider
-- Installed via Lazy.nvim

return {
  "chrisgrieser/nvim-spider",
  event = "VeryLazy",
  config = function()
    require("spider").setup({
      skipInsignificantPunctuation = true,
      consistentOperatorPending = false,
      subwordMovement = true,
    })

    -- Replace default w, e, b motions with spider versions
    vim.keymap.set({ "n", "o", "x" }, "\\w", "<cmd>lua require('spider').motion('w')<CR>")
    vim.keymap.set({ "n", "o", "x" }, "\\e", "<cmd>lua require('spider').motion('e')<CR>")
    vim.keymap.set({ "n", "o", "x" }, "\\b", "<cmd>lua require('spider').motion('b')<CR>")
    vim.keymap.set({ "n", "o", "x" }, "\\ge", "<cmd>lua require('spider').motion('ge')<CR>")
  end,
}
