return {
  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    config = function()
      require("catppuccin").setup({
        transparent_background = true,
        custom_highlights = function(colors)
          return {
            GitSignsCurrentLineBlame = { fg = "#8e847d" },
          }
        end,
      })
    end,
  },
}
