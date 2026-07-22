require('mini.files').setup {
mappings = {
    -- opn file and quit mini.files
    go_in_plus  = '<CR>',
    -- go out and show all item to right
    go_out      = 'H',
    -- go out and show 1 item to right
    go_out_plus = 'h',
  },
  options = {
    use_as_default_explorer = true,
  },
  windows = {
    preview = true,
    width_focus = 30,
    width_nofocus = 30,
    width_preview = 100,
  },
}
