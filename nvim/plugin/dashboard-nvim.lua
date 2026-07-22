require('dashboard').setup {
  theme = 'hyper',
  shortcut_type = 'number',
  config = {
    week_header = {
      enable = true,
    },
    shortcut = {
      {
        desc = 'Smart Picker',
        group = 'Label',
        action = 'lua Snacks.picker.smart()',
        key = 'f',
      },
      {
        desc = 'Lazygit',
        group = 'Label',
        action = 'lua LazygitToggle()',
        key = 'l',
      },
      {
        desc = 'Restore Session',
        group = 'Label',
        action = 'lua require("persistence").load()',
        key = 's',
      },
      {
        desc = 'Quit',
        group = 'Constant',
        action = 'q',
        key = 'q',
      },
    },
    mru = { enable = false },
    footer = {},
  },
}
