vim.cmd([[
    set guioptions-=e " Use showtabline in gui vim
    set guioptions+=! " Use showtabline in gui vim
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
o.cursorline = false
-- o.colorcolumn = "80"

-- o.cursorlineopt = "number"
o.equalalways = false
o.splitright = true
o.splitbelow = true

-- Tabs
o.autoindent = true
o.cindent = true
o.wrap = true

o.tabstop = 4
o.shiftwidth = 4
o.softtabstop = 4
o.expandtab = true

o.breakindent = true
o.showbreak = string.rep(" ", 3) -- Make it so that long lines wrap smartly
o.linebreak = true

o.foldmethod = "marker"
o.foldlevel = 0
o.modelines = 1

o.belloff = "all" -- Just turn the dang bell off

-- o.clipboard = "unnamedplus"

o.inccommand = "split"
-- o.shada = { "!", "'1000", "<50", "s10", "h" }

o.mouse = o.mouse .. "a"

-- o.shortmess = "c"

-- o.winbar = "%=%m\\ %f"

-- Helpful related items:
--   1. :center, :left, :right
--   2. gw{motion} - Put cursor back after formatting motion.
--
-- TODO: w, {v, b, l}
--[[ o.formatoptions = o.formatoptions
  - "a" -- Auto formatting is BAD.
  - "t" -- Don't auto format my code. I got linters for that.
  + "c" -- In general, I like it when comments respect textwidth
  + "q" -- Allow formatting comments w/ gq
  - "o" -- O and o, don't continue comments
  + "r" -- But do continue when pressing enter.
  + "n" -- Indent past the formatlistpat, not underneath it.
  + "j" -- Auto-remove comments if possible.
  - "2" -- I'm not in gradeschool anymore
  ]]
--

-- o.formatoptions = o.formatoptions - "c" - "r" - "o"

-- set joinspaces

o.joinspaces = false -- Two spaces and grade school, we're done

-- set fillchars=eob:~
--o.fillchars = 'eob="~"'

-- o.guicursor = ""

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
-- o.isfname = "@-@"

-- Give more space for displaying messages.
o.cmdheight = 1

-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
o.updatetime = 50

-- vim.opt.fillchars = { eob = "" }

vim.cmd("set formatoptions-=cro")

o.list = true
o.listchars = "eol:↴"
-- o.fillchars = { eob = "" }
