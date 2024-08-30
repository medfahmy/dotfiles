local o = vim.o

o.timeout = true
o.timeoutlen = 300
o.completeopt = "menuone,noselect"

o.guicursor = "a:block"
o.pumblend = 17
o.wildmode = "longest:full"
o.wildoptions = "pum"
o.title = true
o.autoread = true
o.conceallevel = 0
o.history = 9000
o.undolevels = 2000
o.lazyredraw = true
o.wildignorecase = true
o.wildignore =
    ".git,.hg,*.o,*.a,*.class,*.jar,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,*.pyc,*.pyo,**/cache/*,**/logs/*,**/target/*,*.hi,tags,**/dist/*,**/public/**/vendor/**,**/public/vendor/**,**/node_modules/**"
o.path = o.path .. "**"
o.showmode = false
o.showcmd = true
o.showmatch = true
o.number = true
o.relativenumber = true
o.ignorecase = true
o.smartcase = true
o.hidden = true
o.cursorline = true
o.colorcolumn = "80"
o.cursorlineopt = "number"
o.equalalways = false
o.splitright = true
o.splitbelow = false
o.autoindent = true
o.cindent = true
o.wrap = true
o.tabstop = 4
o.shiftwidth = 4
o.softtabstop = 4
o.expandtab = true
o.breakindent = true
o.showbreak = string.rep(" ", 3)
o.linebreak = true
o.foldmethod = "marker"
o.foldlevel = 0
o.modelines = 1
o.belloff = "all"
-- o.clipboard = "unnamedplus"
o.inccommand = "split"
o.mouse = o.mouse .. "a"
o.laststatus = 3
o.shortmess = "aW"
-- o.winbar = "%=%m\\ %f"
o.errorbells = false
o.smartindent = true
o.swapfile = false
o.backup = false
o.undodir = os.getenv("HOME") .. "/.vim/undodir"
o.undofile = true
o.hlsearch = false
o.incsearch = true
o.termguicolors = true
o.scrolloff = 8
o.signcolumn = "yes"
-- o.cmdheight = 2
o.updatetime = 50
o.list = true
o.listchars = "eol:↴"
o.fillchars = "eob: "
o.formatoptions = ""



vim.cmd([[
    set guioptions-=e
    set guioptions+=!
    set sessionoptions+=tabpages,globals
    set shellcmdflag-=ic
    syntax enable

    set laststatus=3
    set statusline=
    set statusline+=%{StatuslineMode()}
    set statusline+=%=
    set statusline+=%{b:gitbranch}
    set statusline+=\ 
    set statusline+=|
    set statusline+=\ 
    set statusline+=%F
    set statusline+=\ 
    set statusline+=|
    set statusline+=\ 
    set statusline+=%y
    set statusline+=\ 
    set statusline+=|
    set statusline+=\ 
    set statusline+=%l
    set statusline+=\ 
    set statusline+=%c
    set statusline+=\ 
    set statusline+=|
    set statusline+=\ 
    set statusline+=%P
    set statusline+=\ 
    set statusline+=%L
    set statusline+=\ 
    set statusline+=|
    set statusline+=\ 
    set statusline+=%{&ff}
    set statusline+=\ 
    set statusline+=%{strlen(&fenc)?&fenc:'none'}
    hi StatusLine guibg=black guifg=white

    function! StatuslineMode()
      let l:mode=mode()
      if l:mode==#"n"
        return "NORMAL"
      elseif l:mode==?"v"
        return "VISUAL"
      elseif l:mode==#"i"
        return "INSERT"
      elseif l:mode==#"R"
        return "REPLACE"
      elseif l:mode==?"s"
        return "SELECT"
      elseif l:mode==#"t"
        return "TERMINAL"
      elseif l:mode==#"c"
        return "COMMAND"
      elseif l:mode==#"!"
        return "SHELL"
      endif
    endfunction

    function! StatuslineGitBranch()
      let b:gitbranch=""
      if &modifiable
        try
          let l:dir=expand('%:p:h')
          let l:gitrevparse = system("git -C ".l:dir." rev-parse --abbrev-ref HEAD")
          if !v:shell_error
            let b:gitbranch="(".substitute(l:gitrevparse, '\n', '', 'g').") "
          endif
        catch
        endtry
      endif
    endfunction

    augroup GetGitBranch
      autocmd!
      autocmd VimEnter,WinEnter,BufEnter * call StatuslineGitBranch()
    augroup END
]])

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    { "norcalli/nvim-colorizer.lua" },
    {
        "folke/which-key.nvim",
        opts = {}
    },
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            signs = {
                add = { text = "+" },
                change = { text = "~" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
            },
        },
    },
    {
        "rmagatti/auto-session",
        opts = { log_level = "error" }
    },
    { "numToStr/Comment.nvim", opts = {} },
    {
        "nvim-telescope/telescope.nvim",
        version = "*",
        dependencies = { "nvim-lua/plenary.nvim" }
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
            return vim.fn.executable "make" == 1
        end,
    },
}, {})

local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = "*",
})

require("telescope").setup()

pcall(require("telescope").load_extension, "fzf")

-- vim.keymap.set("n", "<space>g", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
vim.keymap.set("n", "<space>b", require("telescope.builtin").buffers, { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<space>/", function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
        winblend = 10,
        previewer = false,
    })
end, { desc = "[/] Fuzzily search in current buffer" })

vim.keymap.set("n", "<space>f", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<space>th", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<space>tw", require("telescope.builtin").grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<space>tg", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<space>td", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })

function map(op, lhs, rhs, opts)
    opts = vim.tbl_extend("force", { noremap = true, silent = true }, opts or {})
    vim.keymap.set(op, lhs, rhs, opts)
end

map({ "n", "v" }, "<space>", "<nop>")
map({ "n", "v" }, "q:", "<nop>")
map({ "n", "v" }, "Q", "<nop>")

map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
map( "n", "<space>y", '"+y')
map( "n", "<space>p", '"+p')
map( "v", "<space>y", '"+y')
map( "v", "<space>p", '"+p')

map("n", "<c-w>", "<c-w>w")

-- jumplist mutations
map("n", "k", '(v:count > 5 ? "m\'" . v:count : "") . \'k\'', { expr = true })
map("n", "j", '(v:count > 5 ? "m\'" . v:count : "") . \'j\'', { expr = true })
map( "n", "{", ":keepjumps normal! {<cr>")
map( "n", "}", ":keepjumps normal! }<cr>")

-- -- indenting selection while staying in visual mode
map("v", "<", "<gv")
map("v", ">", ">gv")

-- -- keeping it centered
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "J", "mzJ`z")
map("n", "<c-d>", "<c-d>zz")
map("n", "<c-u>", "<c-u>zz")
map("n", "{", "{zz")
map("n", "}", "}zz")

-- -- undo break points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", "!", "!<c-g>u")
map("i", "?", "?<c-g>u")
map("i", "(", "(<c-g>u")
map("i", ")", ")<c-g>u")
map("i", "{", "{<c-g>u")
map("i", "}", "}<c-g>u")
map("i", "[", "[<c-g>u")
map("i", "]", "]<c-g>u")
map("i", "<", "<<c-g>u")
map("i", ">", "><c-g>u")


local colors = {
    comment = "#999999",
    comment_light = "#999999",
    contrast = "#191919",
    background = "none",
    black = "#121111",
    foreground = "#dfdddd",
    cursorline = "#111111",
    cursor = "#dfdddd",
    color0 = "#1b1b1b",
    color1 = "#dddddd",
    color2 = "#99c794",
    color3 = "#fac863",
    color5 = "#f99157",
    color12 = "#8097fb",
    color6 = "#99c794",
    color7 = "#b7b7b7",
    color8 = "#272727",
    color9 = "#ec5f67",
    color10 = "#99c794",
    color11 = "#c594c5",
    color14 = "#5fafd7",
    color13 = "#8250df",
    color4 = "#54aeff",
    color15 = "#d4d5d5",
}

local highlights = {
    Normal = { fg = colors.foreground, bg = colors.background },
    SignColumn = { bg = colors.background, fg = colors.background },
    MsgArea = { fg = colors.foreground, bg = colors.background },
    ModeMsg = { fg = colors.foreground, bg = colors.background },
    MsgSeparator = { fg = colors.foreground, bg = colors.background },
    SpellBad = { fg = colors.color2 },
    SpellCap = { fg = colors.color12 },
    SpellLocal = { fg = colors.color12 },
    SpellRare = { fg = colors.color4 },
    NormalNC = { fg = colors.foreground, bg = colors.background },
    Pmenu = { fg = colors.foreground, bg = colors.background },
    PmenuSel = { fg = colors.black, bg = colors.color4 },
    WildMenu = { fg = colors.color7, bg = colors.color4 },
    CursorLineNr = { fg = colors.color3 },
    Comment = { fg = colors.comment, italic = true },
    Folded = { fg = colors.color4, bg = colors.background },
    FoldColumn = { fg = colors.color12, bg = colors.background },
    LineNr = { fg = "#555555", bg = colors.background },
    FloatBorder = { fg = colors.foreground, bg = colors.background },
    Whitespace = { fg = colors.color0 },
    VertSplit = { fg = colors.cursorline, bg = colors.background },
    CursorLine = { bg = colors.cursorline },
    CursorColumn = { bg = colors.background },
    ColorColumn = { bg = colors.background },
    NormalFloat = { bg = colors.background },
    Visual = { bg = "#444444" },
    VisualNOS = { bg = colors.background },
    WarningMsg = { fg = colors.color3, bg = colors.background },
    DiffAdd = { bg = colors.background, fg = colors.color12 },
    DiffChange = { bg = colors.background, fg = colors.color5 },
    DiffDelete = { bg = colors.background, fg = colors.color1 },
    QuickFixLine = { bg = colors.color2 },
    PmenuSbar = { bg = colors.background },
    PmenuThumb = { bg = colors.color2 },
    MatchParen = { fg = colors.color12, bg = colors.background },
    Cursor = { fg = colors.comment, bg = colors.cursor },
    lCursor = { fg = colors.foreground, bg = colors.cursor },
    CursorIM = { fg = colors.foreground, bg = colors.cursor },
    TermCursor = { fg = colors.foreground, bg = colors.cursor },
    TermCursorNC = { fg = colors.foreground, bg = colors.cursor },
    Conceal = { fg = colors.color4, bg = colors.background },
    Directory = { fg = colors.color12 },
    SpecialKey = { fg = colors.color12 },
    Title = { fg = colors.color11 },
    ErrorMsg = { fg = colors.color9, bg = colors.background },
    Search = { fg = colors.background, bg = colors.color10 },
    IncSearch = { fg = colors.background, bg = colors.color11 },
    Substitute = { fg = colors.color3, bg = colors.color12 },
    MoreMsg = { fg = colors.color5 },
    Question = { fg = colors.color5 },
    EndOfBuffer = { fg = colors.background },
    NonText = { fg = "#666666" },
    Variable = { fg = colors.color5 },
    String = { fg = colors.color10 },
    Character = { fg = colors.color3 },
    Constant = { fg = colors.color4 },
    Number = { fg = colors.color3 },
    Boolean = { fg = colors.color3 },
    Float = { fg = colors.color3 },
    Identifier = { fg = colors.color1 },
    Function = { fg = colors.color4 },
    Operator = { fg = colors.color4 },
    Type = { fg = colors.color12 },
    StorageClass = { fg = colors.color3 },
    Structure = { fg = colors.color12 },
    Typedef = { fg = colors.color5 },
    Keyword = { fg = colors.color11 },
    Statement = { fg = colors.color5 },
    Conditional = { fg = colors.color11 },
    Repeat = { fg = colors.color11 },
    Label = { fg = colors.color12 },
    Exception = { fg = colors.color7 },
    Include = { fg = colors.color5 },
    PreProc = { fg = colors.color12 },
    Define = { fg = colors.color12 },
    Macro = { fg = colors.color12 },
    PreCondit = { fg = colors.color12 },
    Special = { fg = colors.color12 },
    SpecialChar = { fg = colors.color12 },
    Tag = { fg = colors.color15 },
    Debug = { fg = colors.color13 },
    Delimiter = { fg = colors.color7 },
    SpecialComment = { fg = colors.color8 },
    Ignore = { fg = colors.color7, bg = colors.background },
    Todo = { fg = colors.color1, bg = colors.background },
    Error = { fg = colors.color9, bg = colors.background },
    TabLine = { fg = colors.color2, bg = colors.background },
    TabLineSel = { fg = colors.foreground, bg = colors.background },
    TabLineFill = { fg = colors.foreground, bg = colors.background },
    IndentBlanklineChar = { fg = "#666666" },
    TelescopePromptNormal = {
        fg = colors.foreground,
        bg = colors.background,
    },
    TelescopePromptPrefix = {
        fg = colors.color1,
        bg = colors.color8,
    },
    TelescopeNormal = { bg = colors.background },
    TelescopePreviewTitle = {
        fg = colors.cursorline,
        bg = colors.cursorline,
    },
    TelescopePromptTitle = {
        fg = colors.background,
        bg = colors.color9,
    },
    TelescopeResultsTitle = {
        fg = colors.cursorline,
        bg = colors.cursorline,
    },
    TelescopeSelection = { bg = colors.color0, fg = colors.foreground },
    TelescopeResultsDiffAdd = {
        fg = colors.color10,
    },
    TelescopeResultsDiffChange = {
        fg = colors.color11,
    },
    TelescopeResultsDiffDelete = {
    fg = colors.color9,
    },
    GitSignsAdd = { fg = colors.color2 },
    GitSignsChange = { fg = colors.color5 },
    GitSignsDelete = { fg = colors.color1 },
    BufflineBufOnActive = { bg = colors.color4, fg = colors.background },
    BufflineBufOnInactive = { fg = colors.color7, bg = colors.contrast },
    BuffLineBufOnModified = { bg = colors.color4, fg = colors.background },
    BuffLineBufOnClose = { bg = colors.color4, fg = colors.background },
    BuffLineBufOffClose = { fg = colors.color9, bg = colors.contrast },
    BuffLineTree = { bg = colors.background, fg = colors.white },
    BuffLineEmpty = { bg = colors.background, fg = colors.white },
}

for group, properties in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, properties)
end
