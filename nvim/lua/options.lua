local o = vim.o

vim.cmd([[set splitbelow splitright]])

o.pumblend = 17
o.wildmode = "longest:full"
o.wildoptions = "pum"

o.title = true
o.number = true
o.autoread = true
o.signcolumn = 'yes'
o.termguicolors = true
o.conceallevel = 1
o.history = 9000
o.undolevels = 2000
o.undofile = true
o.lazyredraw = true
o.wildignorecase = true
o.wildignore = '.git,.hg,*.o,*.a,*.class,*.jar,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,*.pyc,*.pyo,**/cache/*,**/logs/*,**/target/*,*.hi,tags,**/dist/*,**/public/**/vendor/**,**/public/vendor/**,**/node_modules/**'
o.path = o.path .. '**'

o.showmode = true
o.showcmd = true
o.cmdheight = 1 -- Height of the command bar
o.incsearch = true -- Makes search act like search in modern browsers
o.showmatch = true -- show matching brackets when text indicator is over them
o.relativenumber = false -- Show line numbers
o.number = true -- But show the actual number for the line we're on
o.ignorecase = true -- Ignore case when searching...
o.smartcase = true -- ... unless there is a capital letter in the query
o.hidden = true -- I like having buffers stay around
o.cursorline = true -- Highlight the current line
o.cursorlineopt = "number"
o.equalalways = false -- I don't like my windows changing all the time
o.splitright = true -- Prefer windows splitting to the right
o.splitbelow = true -- Prefer windows splitting to the bottom
o.updatetime = 1000 -- Make updates happen faster
o.hlsearch = false -- I wouldn't use this without my DoNoHL function
o.scrolloff = 10 -- Make it so there are always ten lines below my cursor

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
o.swapfile = false -- Living on the edge
-- o.shada = { "!", "'1000", "<50", "s10", "h" }

o.mouse = o.mouse .. 'a'

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
  ]]--

-- set joinspaces
o.joinspaces = false -- Two spaces and grade school, we're done

-- set fillchars=eob:~
--o.fillchars = 'eob="~"'
