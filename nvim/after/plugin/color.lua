local colors = {
    bg = "#222222",
    black = "#343d46",
    gray0 = "#444444",
    gray1 = "#666666",
    gray2 = "#a7adba",
    gray3 = "#c0c5ce",
    gray4 = "#cdd3de",
    white = "#f0f0f0",
    red = "#ec5f67",
    orange = "#f99157",
    yellow = "#fac863",
    green = "#99c794",
    cyan = "#5fafd7",
    blue = "#54aeff",
    purple = "#c594c5",
    -- purple = "#8250df",
    brown = "#ab7967",
}

vim.g.colorscheme = "OceanicNext"
vim.cmd("syntax enable")
vim.cmd("colorscheme " .. vim.g.colorscheme)

local hl = function(thing, opts)
    vim.api.nvim_set_hl(0, thing, opts)
end

local none = none

hl("SignColumn", { bg = none, fg = none })
hl("Visual", { bg = colors.gray0, fg = colors.white })
hl("EndOfBuffer", { bg = none, fg = none })
hl("CursorLineNr", { fg = colors.yellow })
hl("Normal", { bg = none })
hl("Pmenu", { bg = colors.bg })
hl("LineNr", { fg = colors.gray1 })
hl("IncSearch", { fg = colors.black, bg = colors.yellow })
hl("TreesitterContextLineNumber", { fg = colors.white, bg = colors.gray0 })
hl("TreesitterContext", { bg = colors.gray0 })
hl("NormalFloat", { bg = colors.gray0 })

-- vim.cmd("hi StatusLine guifg=Black guibg=Gray")
