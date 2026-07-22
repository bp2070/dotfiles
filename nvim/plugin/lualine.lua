local theme = require('lualine.themes.everforest')
theme.normal.c.bg = 'none'
theme.command.c.bg = 'none'
theme.visual.c.bg = 'none'
theme.insert.c.bg = 'none'

require("lualine").setup({
  options = {
    theme = theme,
  },
  sections = {
    lualine_c = {
      {
        'filename',
        path = 1,
      }
    },
  },
})
