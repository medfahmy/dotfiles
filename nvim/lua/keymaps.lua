vim.cmd([[
    nnoremap <Space> <NOP>

    inoremap <c-c> <esc>
    vnoremap <c-c> <esc>
    nnoremap <c-c> <esc>

    cnoremap <C-p> <Up>
    cnoremap <C-n> <Down>

    nnoremap <leader>o :%bd\|e#\|bd#<cr>

    " buffers
    nnoremap <silent> <Tab> :bnext<cr>
    nnoremap <silent> <S-Tab> :bprevious<cr>
    " nnoremap <leader>x <cmd> bd <cr>

    " using system clipboard
    nnoremap <leader>y "+y
    nnoremap <leader>Y "+y$
    nnoremap <leader>p "+p
    vnoremap <leader>y "+y
    nnoremap <leader>Y "+y$
    vnoremap <leader>p "+p

    nnoremap <leader>mr <cmd>make run<cr>
    nnoremap <leader>mb <cmd>make build<cr>

    tnoremap <C-[> <C-\><C-N>

    nnoremap Y y$
    map q: <Nop>
    nnoremap Q <nop>

    " moving text
    vnoremap <silent> J :m '>+1<CR>gv=gv
    vnoremap <silent> K :m '<-2<CR>gv=gv
    " inoremap <C-j> <esc>:m .+1<CR>==
    " inoremap <C-k> <esc>:m .-2<CR>==
    " nnoremap <leader>j :m .+1<CR>==
    " nnoremap <leader>k :m .-2<CR>==

    " indenting selection while staying in visual mode
    vnoremap < <gv
    vnoremap > >gv

    " keeping it centered
    nnoremap n nzzzv
    nnoremap N Nzzzv
    nnoremap J mzJ`z

    " undo break points
    inoremap , ,<c-g>u
    inoremap . .<c-g>u
    inoremap ! !<c-g>u
    inoremap ? ?<c-g>u
    inoremap ( (<c-g>u
    inoremap ) )<c-g>u
    inoremap { {<c-g>u
    inoremap } }<c-g>u
    inoremap [ [<c-g>u
    inoremap ] ]<c-g>u
    inoremap < <<c-g>u
    inoremap > ><c-g>u

    " jumplist mutations
    nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
    nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'

    vnoremap <leader>" <esc>`>a"<esc>`<i"<esc>
    vnoremap <leader>( <esc>`>a)<esc>`<i(<esc>
    vnoremap <leader>[ <esc>`>a]<esc>`<i[<esc>
    vnoremap <leader>' <esc>`>a'<esc>`<i'<esc>
    vnoremap <leader>{ <esc>`>a}<esc>`<i{<esc>

    nnoremap <silent>{ :keepjumps normal! {<cr>
    nnoremap <silent>} :keepjumps normal! }<cr>
]])

