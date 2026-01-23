-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Add empty lines before and after cursor line
vim.keymap.set("n", "<CR>", "o<Esc>")

-- grug-far
vim.keymap.set({ 'n', 'x' }, '<leader>srr', function()
  require('grug-far').open()
end, { desc = 'grug-far: Search and replace' })

vim.keymap.set({ 'n', 'x' }, '<leader>srf', function()
  require('grug-far').open({ prefills = { paths = vim.fn.expand("%") } })
end, { desc = 'grug-far: Search within file' })

vim.keymap.set({ 'n', 'x' }, '<leader>sri', function()
  require('grug-far').open({ visualSelectionUsage = 'operate-within-range' })
end, { desc = 'grug-far: Search within range' })
