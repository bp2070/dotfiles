require("catppuccin").setup {
    custom_highlights = function(colors)
        return {
            WinSeparator = { fg = colors.mauve },
        }
    end
}

vim.cmd.colorscheme "catppuccin"
