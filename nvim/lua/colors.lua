local colors = {
    -- none = "#0F1B22",
    none = "none",
    gray1 = "#343D46",
    gray2 = "#4F5B66",
    gray3 = "#65737E",
    gray4 = "#A7ADBA",
    gray5 = "#C0C5CE",
    gray6 = "#CDD3DE",
    white = "#cfcfcf",
    blue = "#61afef",
    orange = "#c99157",
    green = "#99C794",
    yellow = "#eAb863",
    -- blue = "#6699CC",
    purple = "#a494C5",
    cyan = "#5FB3B3",
    brown = "#A07967",
    magenta = "#64c6e3",
}

-- local colors = {
--     none = "none",
--     gray1 = "#343D46",
--     gray2 = "#4F5B66",
--     gray3 = "#65737E",
--     gray4 = "#A7ADBA",
--     gray5 = "#C0C5CE",
--     gray6 = "#CDD3DE",
--     white = "#D8DEE9",
--     blue = "#61afef",
--     orange = "#F99157",
--     green = "#99C794",
--     yellow = "#FAC863",
--     blue = "#6699CC",
--     purple = "#C594C5",
--     cyan = "#5FB3B3",
--     brown = "#AB7967",
-- }

-- base 00: #1B2B34
-- base 01: #343D46
-- base 02: #4F5B66
-- base 03: #65737E
-- base 04: #A7ADBA
-- base 05: #C0C5CE
-- base 06: #CDD3DE
-- base 07: #D8DEE9
-- base 08: #EC5f67
-- base 09: #F99157
-- base 0A: #FAC863
-- base 0B: #99C794
-- base 0C: #5FB3B3
-- base 0D: #6699CC
-- base 0E: #C594C5
-- base 0F: #AB7967

vim.o.background = "dark"

local function highlight(group, fg, bg, attrs)
    local command = 'hi ' .. group
    if fg then command = command .. ' guifg=' .. fg end
    if bg then command = command .. ' guibg=' .. bg end
    if attrs then command = command .. ' gui=' .. attrs end
    vim.cmd(command)
end

vim.cmd('colorscheme default')

highlight("Normal", colors.white, colors.none)
highlight("Visual", nil, colors.gray2)
highlight("Comment", colors.gray4, nil, "italic")
highlight("Constant", colors.blue, nil)
highlight("String", colors.green, nil)
highlight("Identifier", colors.cyan, nil)
highlight("Function", colors.cyan, nil)
highlight("Statement", colors.blue, nil)
highlight("PreProc", colors.purple, nil)
highlight("Type", colors.blue, nil)
highlight("Special", colors.yellow, nil)
highlight("Underlined", colors.purple, nil, "underline")
highlight("Todo", colors.blue, nil, "bold")

highlight("CursorLine", nil, colors.gray1)
highlight("CursorLineNr", colors.yellow, colors.gray1)

highlight("Search", colors.none, colors.purple)
highlight("IncSearch", colors.none, colors.green)

highlight("StatusLine", colors.white, colors.gray2)
highlight("StatusLineNC", colors.gray4, colors.gray2)
highlight("VertSplit", colors.gray3, nil)

highlight("Error", colors.blue, nil)
highlight("Warning", colors.purple, nil)

highlight("Boolean", colors.orange, nil)
highlight("Number", colors.orange, nil)
highlight("Operator", colors.blue, nil)
highlight("Type", colors.magenta, nil)
highlight("StorageClass", colors.brown, nil)

highlight("LineNr", colors.gray2, nil)

highlight("TabLine", colors.gray3, nil)
highlight("TabLineFill", colors.gray2, nil)
highlight("TabLineSel", colors.white, colors.gray2)

highlight("Pmenu", colors.white, colors.gray2)
highlight("PmenuSel", colors.white, colors.blue)
highlight("PmenuSbar", colors.gray3, nil)
highlight("PmenuThumb", colors.gray4, nil)

vim.cmd [[
  hi GitSignsAdd          guifg=#99C794 guibg=NONE gui=bold
  hi GitSignsChange       guifg=#eab813  guibg=NONE gui=italic
  hi GitSignsDelete       guifg=#dC5f67 guibg=NONE gui=bold
  hi GitSignsAddLn        guifg=#99C794 guibg=NONE
  hi GitSignsChangeLn     guifg=#eab813 guibg=NONE
  hi GitSignsDeleteLn     guifg=#dC5f67 guibg=NONE
]]
