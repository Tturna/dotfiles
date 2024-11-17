-- catppuccin theme configuration
require("catppuccin").setup({
    flavour = "macchiato",
    transparent_background = true,
    term_colors = false, -- terminal colors
})

-- setup must be called before loading
vim.cmd.colorscheme "catppuccin"
