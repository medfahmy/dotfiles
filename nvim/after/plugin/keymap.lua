function bind(op, outer_opts)
    outer_opts = outer_opts or { noremap = true, silent = true }
    return function(lhs, rhs, opts)
        opts = vim.tbl_extend("force", outer_opts, opts or {})
        vim.keymap.set(op, lhs, rhs, opts)
    end
end

map = bind("", { noremap = false })
nmap = bind("n", { noremap = false })
nnoremap = bind("n")
vnoremap = bind("v")
xnoremap = bind("x")
inoremap = bind("i")
tnoremap = bind("t")
cnoremap = bind("c")


-- globals
nnoremap("<space>", "<nop>")

inoremap("<c-c>", "<esc>")
vnoremap("<c-c>", "<esc>")
nnoremap("<c-c>", "<esc>")

cnoremap("<c-p>", "<up>")
cnoremap("<c-n>", "<down>")

-- buffers
nnoremap("<tab>", "<cmd>bnext<cr>")
nnoremap("<s-tab>", "<cmd>bprevious<cr>")
nnoremap("<space>x", "<cmd>bd<cr>")
nnoremap("<space>o", "<cr>%bd\\|e#\\|bd#<cr>")

-- using system clipboard
nnoremap("<space>y", '"+y')
nnoremap("<space>Y", '"+y$')
nnoremap("<space>p", '"+p')
vnoremap("<space>y", '"+y')
nnoremap("<space>Y", '"+y$')
vnoremap("<space>p", '"+p')

-- nnoremap("<space>mr", "<cmd>make run<cr>")
-- nnoremap("<space>mb", "<cmd>make build<cr>")

tnoremap("<c-[>", "<c-\\><c-N>")

nnoremap("Y", "y$")
map("q:", "<nop>")
nnoremap("Q", "<nop>")

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
nnoremap("<expr>", "k (v:count > 5 ? \"m'\" . v:count : \"\") . 'k'")
nnoremap("<expr>", "j (v:count > 5 ? \"m'\" . v:count : \"\") . 'j'")

vnoremap('<space>"', '<esc>`>a"<esc>`<i"<esc>')
vnoremap("<space>(", "<esc>`>a)<esc>`<i(<esc>")
vnoremap("<space>[", "<esc>`>a]<esc>`<i[<esc>")
vnoremap("<space>'", "<esc>`>a'<esc>`<i'<esc>")
vnoremap("<space>{", "<esc>`>a}<esc>`<i{<esc>")

nnoremap("<silent>{", ":keepjumps normal! {<cr>")
nnoremap("<silent>}", ":keepjumps normal! }<cr>")


-- telescope
local telescope = require("telescope.builtin")

nnoremap("<space>tt", "<cmd>Telescope<cr>")
nnoremap("<space>f", telescope.find_files)
nnoremap("<space>tg", telescope.live_grep)
nnoremap("<space>tf", telescope.git_files)
nnoremap("<space>b", telescope.buffers)
nnoremap("<space>tc", telescope.colorscheme)
nnoremap("<space>ts", telescope.lsp_dynamic_workspace_symbols)
nnoremap("<space>tk", telescope.keymaps)
nnoremap("<space>th", telescope.help_tags)


-- formatter
nnoremap("<space>=", ":Format<cr>")

-- comment
nnoremap("<c-_>", ":CommentToggle<cr>")
vnoremap("<c-_>", ":'<, '>CommentToggle<cr>")

nnoremap("<space>n", "<cmd>NvimTreeToggle<cr>")
