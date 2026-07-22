require("toggleterm").setup({
  shell = 'pwsh -NoLogo',
})

function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
end
-- Apply these mappings only when a terminal is open
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

local Terminal = require('toggleterm.terminal').Terminal

local float_term = Terminal:new({
  direction = "float",
  hidden = true,
})

function FloatTermToggle()
  float_term:toggle()
end

local lazygit = Terminal:new({
  cmd = "lazygit",
  hidden = true,
  direction = "float",
})

function LazygitToggle()
  lazygit:toggle()
end

vim.keymap.set("n", '<leader>t', FloatTermToggle, { desc = "ToggleTerm" })
vim.keymap.set("n", "<leader>gg", LazygitToggle, { desc = "Lazygit" })
