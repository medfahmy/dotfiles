-- Hide semantic highlights for functions
-- vim.api.nvim_set_hl(0, '@lsp.type.function', {})
-- Hide all semantic highlights
-- for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
--  vim.api.nvim_set_hl(0, group, {})
-- end

local colors = {
    silver = "#555555",
    black = "#272727",
    none = "none",
    white = "#dfdddd",
    gray  = "#444444",
    light = "#999999",
    green = "#99c794",
    yellow = "#fac863",
    purple = "#c594c5",
    magenta = "#8097fb",
    -- cyan = "#8097fb",
    -- orange = "#8097fb",
    red = "#ec5f67",
    orange = "#f99157",
    cyan = "#5fafd7",
    violet = "#8250df",
    blue = "#0386fc"
}

require("colorbuddy").colorscheme('gruvbuddy')
vim.cmd('colorscheme gruvbuddy')

local colorbuddy = require('colorbuddy')
local Color = colorbuddy.Color
local Group = colorbuddy.Group
local c = colorbuddy.colors
local g = colorbuddy.groups
local s = colorbuddy.styles

-- Color.new('white', colors.white)
Color.new('red', colors.yellow)
-- Color.new('pink', colors.violet)
-- Color.new('green',colors.green)
Color.new('yellow', colors.cyan)
-- Color.new('blue', colors.blue)
-- Color.new('aqua', colors.sky)
-- Color.new('cyan', colors.cyan)
Color.new('purple', colors.purple)
Color.new('violet', '#8e6fbd')
-- Color.new('orange', colors.cyan)
-- Color.new('brown', colors.orane)

-- Color.new('seagreen', '#698b69')
-- Color.new('turquoise', '#698b69')

-- Color.new('white', '#f2e5bc')
-- Color.new('red', '#cc6666')
-- Color.new('pink', '#fef601')
-- Color.new('green', '#99cc99')
-- Color.new('yellow', '#f8fe7a')
-- Color.new('blue', '#81a2be')
-- Color.new('aqua', '#8ec07c')
-- Color.new('cyan', '#8abeb7')
-- Color.new('purple', '#8e6fbd')
-- Color.new('violet', '#b294bb')
-- Color.new('orange', '#de935f')
-- Color.new('brown', '#a3685a')
--
-- Color.new('seagreen', '#698b69')
Color.new('turquoise', colors.blue)

-- local background_string = "#111111"
-- local background_string = "#000000"
-- Color.new("background", background_string)
-- Color.new("gray0", background_string)
--
-- Group.new("Normal", c.superwhite, c.gray0)
--
-- Group.new("@constant", c.yellow, nil, s.none)
-- Group.new("@function", c.yellow, nil, s.none)
-- Group.new("@function.bracket", g.Normal, g.Normal)
Group.new("@keyword", c.turquoise, nil, s.none)
-- Group.new("@keyword.faded", g.nontext.fg:light(), nil, s.none)
-- Group.new("@property", c.blue)
-- Group.new("@variable", c.superwhite, nil)
-- Group.new("@variable.builtin", c.purple:light():light(), g.Normal)

local highlights = {
    Normal = { fg = colors.white, bg = colors.none },
    SignColumn = { bg = colors.none, fg = colors.background },
--     MsgArea = { fg = colors.white, bg = colors.none },
--     ModeMsg = { fg = colors.white, bg = colors.none },
--     MsgSeparator = { fg = colors.white, bg = colors.none },
--     SpellBad = { fg = colors.green },
--     SpellCap = { fg = colors.purple },
--     SpellLocal = { fg = colors.purple },
--     SpellRare = { fg = colors.blue },
--     NormalNC = { fg = colors.white, bg = colors.none },
--     Pmenu = { fg = colors.white, bg = colors.none },
--     PmenuSel = { fg = colors.black, bg = colors.blue },
--     WildMenu = { fg = colors.white, bg = colors.blue },
    CursorLineNr = { fg = colors.yellow },
--     Comment = { fg = colors.light },
--     Folded = { fg = colors.blue, bg = colors.none },
--     FoldColumn = { fg = colors.purple, bg = colors.none },
    LineNr = { fg = colors.silver, bg = colors.none },
--     FloatBorder = { fg = colors.white, bg = colors.none },
--     Whitespace = { fg = colors.black },
--     VertSplit = { fg = colors.gray, bg = colors.none },
--     CursorLine = { bg = colors.gray },
--     CursorColumn = { bg = colors.none },
--     ColorColumn = { bg = colors.white },
--     NormalFloat = { bg = colors.none },
    Visual = { bg = colors.silver },
--     VisualNOS = { bg = colors.none },
--     WarningMsg = { fg = colors.yellow, bg = colors.none },
--     DiffAdd = { bg = colors.none, fg = colors.purple },
--     DiffChange = { bg = colors.none, fg = colors.magenta },
--     DiffDelete = { bg = colors.none, fg = colors.white },
--     QuickFixLine = { bg = colors.green },
--     PmenuSbar = { bg = colors.none },
--     PmenuThumb = { bg = colors.green },
--     MatchParen = { fg = colors.purple, bg = colors.none },
--     Cursor = { fg = colors.silver, bg = colors.white },
--     lCursor = { fg = colors.white, bg = colors.white },
--     CursorIM = { fg = colors.white, bg = colors.white },
--     TermCursor = { fg = colors.white, bg = colors.white },
--     TermCursorNC = { fg = colors.white, bg = colors.white },
--     Conceal = { fg = colors.blue, bg = colors.none },
--     Directory = { fg = colors.purple },
--     SpecialKey = { fg = colors.purple },
--     Title = { fg = colors.sky },
--     ErrorMsg = { fg = colors.red, bg = colors.none },
--     Search = { fg = colors.none, bg = colors.green },
--     IncSearch = { fg = colors.none, bg = colors.sky },
--     Substitute = { fg = colors.yellow, bg = colors.purple },
--     MoreMsg = { fg = colors.magenta },
--     Question = { fg = colors.magenta },
--     EndOfBuffer = { fg = colors.none },
--     NonText = { fg = colors.silver },
--     Variable = { fg = colors.magenta },
--     String = { fg = colors.green },
--     Character = { fg = colors.yellow },
--     Constant = { fg = colors.blue },
--     Number = { fg = colors.yellow },
--     Boolean = { fg = colors.yellow },
--     Float = { fg = colors.yellow },
--     Identifier = { fg = colors.white },
--     Function = { fg = colors.purple },
--     Operator = { fg = colors.blue },
--     Type = { fg = colors.cyan },
--     StorageClass = { fg = colors.orange },
--     Structure = { fg = colors.purple },
--     Typedef = { fg = colors.cyan },
--     Keyword = { fg = colors.sky },
--     Statement = { fg = colors.magenta },
--     Conditional = { fg = colors.sky },
--     Repeat = { fg = colors.sky },
--     Label = { fg = colors.purple },
--     Exception = { fg = colors.white },
--     Include = { fg = colors.magenta },
--     PreProc = { fg = colors.purple },
--     Define = { fg = colors.cyan },
--     Macro = { fg = colors.purple },
--     PreCondit = { fg = colors.purple },
--     Special = { fg = colors.purple },
--     SpecialChar = { fg = colors.purple },
--     Tag = { fg = colors.white },
--     Debug = { fg = colors.violet },
--     Delimiter = { fg = colors.white },
--     SpecialComment = { fg = colors.light },
--     Ignore = { fg = colors.white, bg = colors.none },
--     Todo = { fg = colors.white, bg = colors.none },
--     Error = { fg = colors.red, bg = colors.none },
--     TabLine = { fg = colors.green, bg = colors.none },
--     TabLineSel = { fg = colors.white, bg = colors.none },
--     TabLineFill = { fg = colors.white, bg = colors.none },
}
--
for group, properties in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, properties)
end
