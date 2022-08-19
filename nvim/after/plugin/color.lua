local colors = {
    bg = "#191919",
    black = "#343d46",
    gray0 = "#4f5b66",
    gray1 = "#65737e",
    gray2 = "#a7adba",
    gray3 = "#c0c5ce",
    gray4 = "#cdd3de",
    white = "#d8dee9",
    red = "#ec5f67",
    orange = "#f99157",
    yellow = "#fac863",
    green = "#99c794",
    cyan = "#5fafd7",
    blue = "#6699cc",
    purple = "#c594c5",
    brown = "#ab7967",
}

vim.g.colorscheme = "OceanicNext"
-- vim.g.colorscheme = "tokyonight"

vim.g.gruvbox_contrast_dark = "hard"
vim.g.tokyonight_transparent_sidebar = true
vim.g.tokyonight_transparent = true
vim.g.gruvbox_invert_selection = "0"
vim.opt.background = "dark"

vim.cmd("syntax enable")

vim.cmd("colorscheme " .. vim.g.colorscheme)

local hl = function(thing, opts)
    vim.api.nvim_set_hl(0, thing, opts)
end

local none = "none"

hl("SignColumn", { bg = none, fg = none })
hl("Visual", { bg = "#444444", fg = "#f0f0f0" })
hl("EndOfBuffer", { bg = none, fg = none })
hl("CursorLineNr", { fg = colors.yellow })
hl("Normal", { bg = none })
hl("Pmenu", { bg = "#222222" })
hl("LineNr", { fg = "#666666" })
-- fg = "#5eacd3",
hl("netrwDir", { fg = "#5eacd3" })
