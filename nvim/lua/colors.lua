local colors = {
    -- none = "#0F1B22",
    none = "none",
    gray1 = "#343D46",
    gray2 = "#4F5B66",
    gray3 = "#65737E",
    gray4 = "#A7ADBA",
    gray5 = "#C0C5CE",
    gray6 = "#CDD3DE",
    white = "#D8DEE9",
    blue = "#61afef",
    orange = "#F99157",
    green = "#99C794",
    yellow = "#FAC863",
    blue = "#6699CC",
    purple = "#C594C5",
    cyan = "#5FB3B3",
    brown = "#AB7967",
}

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
highlight("Comment", colors.gray4, nil, "italic")
highlight("Constant", colors.blue, nil)
highlight("String", colors.green, nil)
highlight("Identifier", colors.cyan, nil)
highlight("Function", colors.purple, nil)
highlight("Statement", colors.blue, nil)
highlight("PreProc", colors.cyan, nil)
highlight("Type", colors.cyan, nil)
highlight("Special", colors.yellow, nil)
highlight("Underlined", colors.purple, nil, "underline")
highlight("Todo", colors.blue, nil, "bold")

highlight("CursorLine", nil, colors.gray1)
highlight("CursorLineNr", colors.white, colors.gray1)

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
highlight("Type", colors.cyan, nil)
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
  hi GitSignsChange       guifg=#FAC863 guibg=NONE gui=italic
  hi GitSignsDelete       guifg=#EC5f67 guibg=NONE gui=bold
  hi GitSignsAddLn        guifg=#99C794 guibg=NONE
  hi GitSignsChangeLn     guifg=#FAC863 guibg=NONE
  hi GitSignsDeleteLn     guifg=#EC5f67 guibg=NONE
]]
