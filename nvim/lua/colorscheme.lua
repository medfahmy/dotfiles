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

require'colorizer'.setup()

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

vim.cmd([[
    syntax enable
    colorscheme OceanicNext

    hi Normal guibg=NONE
    hi LineNr guibg=NONE guifg=#666666
    hi SignColumn guibg=NONE guifg=NONE
    hi EndOfBuffer guibg=NONE
    hi Visual guibg=#444444  guifg=#f0f0f0 
    hi Pmenu guibg=#222222
    hi CursorLineNr guibg=NONE guifg=#fac863 
]])
