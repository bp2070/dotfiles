require("blink.cmp").setup({
  completion = {
    documentation = {
      auto_show = true,
    },
  },

  keymap = {
    -- these are the default blink keymaps
    ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },
    ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
    ['<C-y>'] = { 'select_and_accept', 'fallback' },
    ['<C-e>'] = { 'cancel', 'fallback' },

    ['<Tab>'] = { 'snippet_forward', 'select_next', 'fallback' },
    ['<S-Tab>'] = { 'snippet_backward', 'select_prev', 'fallback' },
    ['<CR>'] = { 'select_and_accept', 'fallback' },
    ['<Esc>'] = { 'cancel', 'hide_documentation', 'fallback' },

    ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },

    ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
    ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

    ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
  },

  fuzzy = {
    implementation = "lua",
  },
})
