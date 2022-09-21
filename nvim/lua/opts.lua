vim.cmd([[
    set guioptions-=e
    set guioptions+=!
    set sessionoptions+=tabpages,globals " store tabpages and globals in session
    set shellcmdflag-=ic
]])

local o = vim.o

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
o.showmode = true
o.showcmd = true
o.showmatch = true
o.number = true
o.relativenumber = false
o.ignorecase = true
o.smartcase = true
o.hidden = true
o.cursorline = true
-- o.colorcolumn = "80"
o.cursorlineopt = "number"
o.equalalways = false
o.splitright = true
o.splitbelow = true
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
-- o.shortmess = "c"
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
o.cmdheight = 2
o.updatetime = 50
o.list = true
o.listchars = "eol:↴"
o.fillchars = "eob: "
-- o.statusline = [[%<%f %h%m%r%=%-14.(%l, %c%V%) %P]]
