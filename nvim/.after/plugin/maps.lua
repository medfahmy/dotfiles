local map = require("keymap").map
local noremap = require("keymap").noremap
local nnoremap = require("keymap").nnoremap
local inoremap = require("keymap").inoremap
local vnoremap = require("keymap").vnoremap
local cnoremap = require("keymap").cnoremap
local tnoremap = require("keymap").tnoremap

-- globals
nnoremap("<space>q", "<cmd>%bd|e#|bd#<cr>")

nnoremap("<c-w>", "<c-w>w")

-- vnoremap("r", [["_dP]])

-- using system clipboard
noremap("<space>y", '"+y')
noremap("<space>Y", '"+y$')
noremap("<space>p", '"+p')
noremap("<space>P", '"+P')

-- nnoremap("<space>mr", "<cmd>make run<cr>")
-- nnoremap("<space>mb", "<cmd>make build<cr>")

-- tnoremap("<c-[>", [[<c-\><c-n>]])
vim.cmd([[tnoremap <c-[><c-[> <c-\><c-n>]])

-- moving text
vnoremap("J", ":m '>+1<CR>gv=gv")
vnoremap("K", ":m '<-2<CR>gv=gv")

-- indenting selection while staying in visual mode
vnoremap("<", "<gv")
vnoremap(">", ">gv")

-- keeping it centered
nnoremap("n", "nzzzv")
nnoremap("N", "Nzzzv")
nnoremap("J", "mzJ`z")
nnoremap("<c-d>", "<c-d>zz")
nnoremap("<c-u>", "<c-u>zz")

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
nnoremap("{", ":keepjumps normal! {<cr>")
nnoremap("}", ":keepjumps normal! }<cr>")

-- /s current word
nnoremap(
    "<space>s",
    ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
    { silent = false }
)
