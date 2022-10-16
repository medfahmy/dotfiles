require("opts")
require("plug")

vim.cmd([[
    set guioptions-=e
    set guioptions+=!
    set sessionoptions+=tabpages,globals
    set shellcmdflag-=ic
    set termguicolors
]])

require("nvim-treesitter.configs").setup({
    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = 1000,
        colors = {
            "#c594c5",
            "#f99157",
            "#5fafd7",
            "#c594c5",
            "#f99157",
            "#5fafd7",
        },
    },
})
