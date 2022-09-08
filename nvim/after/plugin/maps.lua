local map = require("keymap").map
local nnoremap = require("keymap").nnoremap
local inoremap = require("keymap").inoremap
local vnoremap = require("keymap").vnoremap
local cnoremap = require("keymap").cnoremap
local tnoremap = require("keymap").tnoremap

-- globals
nnoremap("<space>", "<nop>")
map("q:", "<nop>")
map("Q", "<nop>")

nnoremap("<space>q", "<cmd>q<cr>")

inoremap("<c-c>", "<esc>")
vnoremap("<c-c>", "<esc>")
nnoremap("<c-c>", "<esc>")

cnoremap("<c-p>", "<up>")
cnoremap("<c-n>", "<down>")

-- buffers
nnoremap("<tab>", "<cmd>bnext<cr>")
nnoremap("<s-tab>", "<cmd>bprevious<cr>")
nnoremap("<space>x", "<cmd>bd!<cr>")
nnoremap("<space>c", "<cmd>%bd|e#<cr>")

-- using system clipboard
nnoremap("<space>y", '"+y')
nnoremap("<space>Y", '"+y$')
nnoremap("<space>p", '"+p')
vnoremap("<space>y", '"+y')
nnoremap("<space>Y", '"+y$')
vnoremap("<space>p", '"+p')

-- nnoremap("<space>mr", "<cmd>make run<cr>")
-- nnoremap("<space>mb", "<cmd>make build<cr>")

tnoremap("<space>[", "<c-\\><c-n>")

nnoremap("Y", "y$")

-- moving text
-- vnoremap <silent> J :m '>+1<CR>gv=gv")
-- vnoremap <silent> K :m '<-2<CR>gv=gv")
-- inoremap <C-j> <esc>:m .+1<CR>==")
-- inoremap <C-k> <esc>:m .-2<CR>==")
-- nnoremap <space>j :m .+1<CR>==")
-- nnoremap <space>k :m .-2<CR>==")

-- indenting selection while staying in visual mode
vnoremap("<", "<gv")
vnoremap(">", ">gv")

-- keeping it centered
nnoremap("n", "nzzzv")
nnoremap("N", "Nzzzv")
nnoremap("J", "mzJ`z")

-- undo break points
inoremap(",", ",<c-g>u")
inoremap(".", ".<c-g>u")
inoremap("!", "!<c-g>u")
inoremap("?", "?<c-g>u")
inoremap("(", "(<c-g>u")
inoremap(")", ")<c-g>u")
inoremap("{", "{<c-g>u")
inoremap("}", "}<c-g>u")
inoremap("[", "[<c-g>u")
inoremap("]", "]<c-g>u")
inoremap("<", "<<c-g>u")
inoremap(">", "><c-g>u")

-- jumplist mutations
nnoremap("k", '(v:count > 5 ? "m\'" . v:count : "") . \'k\'', { expr = true })
nnoremap("j", '(v:count > 5 ? "m\'" . v:count : "") . \'j\'', { expr = true })

-- wrapping visual selection
vnoremap('<space>"', '<esc>`>a"<esc>`<i"<esc>')
vnoremap("<space>(", "<esc>`>a)<esc>`<i(<esc>")
vnoremap("<space>[", "<esc>`>a]<esc>`<i[<esc>")
vnoremap("<space>'", "<esc>`>a'<esc>`<i'<esc>")
vnoremap("<space>{", "<esc>`>a}<esc>`<i{<esc>")

-- dont mutate jump list
nnoremap("<silent>{", ":keepjumps normal! {<cr>")
nnoremap("<silent>}", ":keepjumps normal! }<cr>")
