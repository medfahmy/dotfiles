-- -- Hide semantic highlights for functions
-- vim.api.nvim_set_hl(0, '@lsp.type.function', {})
-- -- Hide all semantic highlights
-- for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
--  vim.api.nvim_set_hl(0, group, {})
-- end
--
-- Define the colors
local colors = {
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
    cyan = "#5FB3B3",
    green = "#99C794",
    yellow = "#FAC863",
    blue = "#6699CC",
    purple = "#C594C5",
    brown = "#AB7967",
}

-- Set the background
vim.o.background = "dark"

-- Create the highlight groups
local function highlight(group, fg, bg, attrs)
    local command = 'hi ' .. group
    if fg then command = command .. ' guifg=' .. fg end
    if bg then command = command .. ' guibg=' .. bg end
    if attrs then command = command .. ' gui=' .. attrs end
    vim.cmd(command)
end

-- Make sure to set the color scheme
vim.cmd('colorscheme default')

-- Set up basic syntax groups
highlight("Normal", colors.white, colors.none)
highlight("Comment", colors.gray4, nil, "italic")
highlight("Constant", colors.blue, nil)
highlight("String", colors.green, nil)
highlight("Identifier", colors.purple, nil)
highlight("Function", colors.cyan, nil)
highlight("Statement", colors.blue, nil)
highlight("PreProc", colors.purple, nil)
highlight("Type", colors.purple, nil)
highlight("Special", colors.yellow, nil)
highlight("Underlined", colors.cyan, nil, "underline")
highlight("Todo", colors.blue, nil, "bold")

-- Set up cursor line and line number colors
highlight("CursorLine", nil, colors.gray1)
highlight("CursorLineNr", colors.white, colors.gray1)

-- Set up search highlighting
highlight("Search", colors.none, colors.cyan)
highlight("IncSearch", colors.none, colors.green)

-- Set up status line and related groups
highlight("StatusLine", colors.white, colors.gray2)
highlight("StatusLineNC", colors.gray4, colors.gray2)
highlight("VertSplit", colors.gray3, nil)

-- Set up error and warning groups
highlight("Error", colors.blue, nil)
highlight("Warning", colors.cyan, nil)

-- Set up syntax groups for highlighting
highlight("Boolean", colors.orange, nil)
highlight("Number", colors.orange, nil)
highlight("Operator", colors.blue, nil)
highlight("Type", colors.purple, nil)
highlight("StorageClass", colors.brown, nil)

-- Set up the color for line numbers
highlight("LineNr", colors.gray4, nil)

-- Set up the color for the tab line
highlight("TabLine", colors.gray3, nil)
highlight("TabLineFill", colors.gray2, nil)
highlight("TabLineSel", colors.white, colors.gray2)

-- Set up special UI elements
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
