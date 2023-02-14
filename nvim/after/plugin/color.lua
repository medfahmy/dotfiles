local colors = {
    bg = "#222222",
    black = "#000000",
    gray0 = "#444444",
    gray1 = "#777777",
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


-- local presets = require("onigiri").presets["mariana"]
-- -- local presets = {}
--
-- presets.Background = {
--     default = "#ffffff",
--     emphasis = "#2e353e",
--     muted = "#46525c",
-- }
--
-- presets.Foreground = {
--     default = "#d8dee9",
--     emphasis = "#f7f7f7",
--     muted = "#a6acb8",
--     surface = "#46525c",
-- }
--
-- presets.Shade = {
--     default = "None",
--     emphasis = "None",
-- }
--
-- Colors = {
--     Accent    = "#95B2D6",
--     Caution   = "#f9ae58",
--     Danger    = "#f97b58",
--     Error     = "#ec5f66",
--     Hint      = "#5fb4b4",
--     Important = "#fac761",
--     Info      = "#99c794",
--     Note      = "#5c99d6",
--     Trace     = "#cc8ec6",
--     Warn      = "#ee932b",
-- }
--
-- vim.g.onigiri = {
--     theme = presets,
-- }

-- require("catppuccin").setup({
--     flavour = "mocha", -- mocha, macchiato, frappe, latte
-- })

vim.g.colorscheme = "habamax"

vim.cmd("syntax enable")
vim.cmd("colorscheme " .. vim.g.colorscheme)

local hl = function(thing, opts)
    vim.api.nvim_set_hl(0, thing, opts)
end

local none = "none"

hl("Normal", { bg = none })
hl("SignColumn", { bg = none, fg = none })
hl("Visual", { bg = "#444444", fg = colors.white })
hl("EndOfBuffer", { bg = none, fg = none })
-- hl("LineNr")
hl("CursorLineNr", { fg = colors.yellow })
hl("Pmenu", { bg = colors.bg })
hl("LineNr", { bg = none, fg = colors.gray1 })
hl("IncSearch", { fg = colors.black, bg = colors.yellow })
hl("TreesitterContextLineNumber", { fg = colors.white, bg = colors.gray0 })
hl("TreesitterContext", { bg = colors.gray0 })
hl("NormalFloat", { bg = "#222222" })
hl("FloatBorder", { bg = none })
hl("StatusLine", { bg = colors.gray1, fg = "#dddddd" })
hl("TSTag", { fg = colors.purple })
hl("NonText", { fg = colors.gray1 })
hl("IndentBlankLineChar", { fg = colors.gray1 })

-- vim.cmd("hi StatusLine guifg=Black guibg=Gray")
