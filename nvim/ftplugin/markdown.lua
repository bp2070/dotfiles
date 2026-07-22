vim.opt_local.wrap = true
vim.opt_local.linebreak = true
vim.opt_local.showbreak = "> "
vim.opt_local.textwidth = 0

require('render-markdown').setup({
  render = {
    diff = true,
  },
})
