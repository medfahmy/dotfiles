--[[ " #2D1078
" #fabd2f
" #5fafd7
" #83a598
]]--


local colors = {
    black = '#343d46',
    gray0 = '#4f5b66',
    gray1 = '#65737e',
    gray2 = '#a7adba',
    gray3 = '#c0c5ce',
    gray4 = '#cdd3de',
    white = '#d8dee9',
    red = '#ec5f67',
    orange = '#f99157',
    yellow = '#fac863',
    green = '#99c794',
    cyan = '#5fb3b3',
    blue = '#6699cc',
    purple = '#c594c5',
    brown = '#ab7967',
}

--[[ local colors = {
  bg = '#202328',
  fg = '#bbc2cf',
  white = '#ffffff',
  yellow = '#fabd2f',
  cyan = '#008080',
  darkblue = '#081633',
  green = '#b8bb26',
  orange = '#fe8019',
  violet = '#d3869b',
  magenta = '#c678dd',
  blue = '#51afef',
  red = '#fb4934',
  darkred = '#cc241d',
  brightgreen = '#00ff00',
  brightyellow = '#ffff00',
  brightred = '#ff0000'
} ]]--

-- vim.cmd([[
--     syntax enable
--     colorscheme tokyonight
--     hi Normal guibg=#191919
--     hi LineNr guibg=NONE guifg=#666666
--     hi SignColumn guibg=NONE guifg=NONE
--     hi EndOfBuffer guibg=NONE guifg=bg
--     hi Visual guibg=#444444  guifg=#f0f0f0
--     hi Pmenu guibg=#222222
--     hi CursorLineNr guibg=NONE guifg=#fac863
-- ]])


vim.g.colorscheme = "tokyonight"

vim.g.gruvbox_contrast_dark = 'hard'
vim.g.tokyonight_transparent_sidebar = true
vim.g.tokyonight_transparent = true
vim.g.gruvbox_invert_selection = '0'
vim.opt.background = "dark"

vim.cmd("colorscheme " .. vim.g.colorscheme)

local hl = function(thing, opts)
    vim.api.nvim_set_hl(0, thing, opts)
end

hl("SignColumn", {
    bg = "none",
})

hl("ColorColumn", {
    ctermbg = 0,
    bg = "#555555",
})

hl("CursorLineNR", {
    bg = "None"
})

hl("Normal", {
    bg = "none"
})

hl("LineNr", {
    fg = "#5eacd3"
})

hl("netrwDir", {
    fg = "#5eacd3"
})


--[[
    set background=dark
    let g:gruvbox_material_palette = 'mix'
    let g:gruvbox_material_background = 'hard'
    let g:gruvbox_material_enable_bold = 1
    let g:gruvbox_material_enable_italic = 1
    let g:gruvbox_material_cursor = 'yellow'
    let g:gruvbox_material_transparent_background = 1
    let g:gruvbox_material_visual = 'green background'
    let g:gruvbox_material_ui_contrast = 'high'
    let g:gruvbox_material_diagnostic_text_highlight = 1
    let g:gruvbox_material_diagnostic_line_highlight = 1
    let g:gruvbox_material_diagnostic_virtual_text = 'colored'
    let g:gruvbox_material_better_performance = 1
    colorscheme gruvbox-material
]]--
