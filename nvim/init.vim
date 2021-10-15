" Plugins
call plug#begin('~/.vim/plugged')

    " COLORSCEMES
    " Plug 'gruvbox-community/gruvbox'
    Plug 'morhetz/gruvbox'
    " Plug 'sainnhe/gruvbox-material'
    Plug 'dracula/vim', { 'as': 'dracula' }
    " Plug 'Mofiqul/dracula.nvim'
    Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
    Plug 'fenetikm/falcon'
    Plug 'dikiaap/minimalist'
    Plug 'kaicataldo/material.vim', { 'branch': 'main' }
    " Plug 'marko-cerovac/material.nvim'
    Plug 'mhartington/oceanic-next'


    " DEPENDENCIES
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'kyazdani42/nvim-web-devicons'

    " LSP
    Plug 'neovim/nvim-lspconfig'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'folke/trouble.nvim'
    Plug 'folke/lsp-colors.nvim'

    " Plug 'HerringtonDarkholme/yats.vim'
    " Plug 'leafgarland/typescript-vim'
    Plug 'peitalin/vim-jsx-typescript'
    Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

    " CMP
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'L3MON4D3/LuaSnip'
    Plug 'saadparwaiz1/cmp_luasnip'
    Plug 'onsails/lspkind-nvim'

    " UTILITIES
    Plug 'nvim-telescope/telescope.nvim'
    " Plug 'sbdchd/neoformat'
    Plug 'mhartington/formatter.nvim'
    Plug 'terrortylor/nvim-comment'
    Plug 'mhinz/vim-startify'
    Plug 'hoob3rt/lualine.nvim'
    Plug 'kdheepak/tabline.nvim'
    Plug 'kyazdani42/nvim-tree.lua'
    Plug 'NTBBloodbath/rest.nvim'
    Plug 'windwp/nvim-ts-autotag'
    Plug 'windwp/nvim-autopairs'
    " Plug 'nvim-neorg/neorg'
    Plug 'airblade/vim-gitgutter' "git signcolumn
    " Plug 'wellle/context.vim'
    Plug 'norcalli/nvim-colorizer.lua'
    " Plug 'voldikss/vim-floaterm'
    Plug 'lukas-reineke/indent-blankline.nvim'

call plug#end()

" SETTINGS
syntax on
set title
set nu
set relativenumber
"set laststatus=2
"set statusline=%F
set mouse+=a
set ruler
" set showcmd
set guicursor+=n-v-c-sm:blinkon0
set cursorline
set culopt=number
set shortmess+=c
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set hidden
set autoread "auto read a file that changed on disk
set noerrorbells
set novisualbell
set wrap "wrap long lines
set incsearch "incrementally highlight while typing search command
set nohlsearch "remove highlight after searching
set ignorecase "case insensitive search
set smartcase "case sensitive if capital
set scrolloff=8
set signcolumn=yes
" set colorcolumn=80
set termguicolors
set noswapfile
set re=0
set conceallevel=1
" set clipboard=unnamedplus "use system clipboard
set noshowmode " dont show mode on command line
set history=9000
set undolevels=2000
set undofile
" set timeoutlen=750
" set lazyredraw
set showmatch
set wildmode=list:lastused " complete files like a shell.
set wildignore=.git,.hg,*.o,*.a,*.class,*.jar,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,*.pyc,*.pyo,**/cache/*,**/logs/*,**/target/*,*.hi,tags,**/dist/*,**/public/**/vendor/**,**/public/vendor/**,**/node_modules/**
set splitbelow splitright
set guioptions-=e
" set sessionoptions+=tabpages,globals
set completeopt=menu,menuone,noselect,noinsert

syntax enable
filetype plugin indent on

" COLORSCHEME

" colorscheme minimalist

 let g:material_terminal_italics = 1
 let g:material_theme_style = 'darker' 
" | 'palenight' | 'ocean' | 'lighter' | 'darker' | 'default-community' | 'palenight-community' | 'ocean-community' | 'lighter-community' | 'darker-community'
 colorscheme material


" let g:gruvbox_contrast_dark='dark'
" let g:gruvbox_invert_selection='0'
" let g:gruvbox_bold='1'
" set background=dark
"  
" colorscheme gruvbox

" colorscheme dracula

" set background=dark
" let g:gruvbox_material_palette = 'original'
" let g:gruvbox_material_background = 'hard'
" let g:gruvbox_material_enable_bold = 1
" let g:gruvbox_material_enable_italic = 0
" let g:gruvbox_material_disable_italic_comment = 1
" let g:gruvbox_material_cursor = 'yellow'
" let g:gruvbox_material_transparent_background = 1
" let g:gruvbox_material_visual = 'green background'
" let g:gruvbox_material_diagnostic_text_highlight = 1
" let g:gruvbox_material_diagnostic_line_highlight = 1
" let g:gruvbox_material_diagnostic_virtual_text = 'colored'
" let g:gruvbox_material_better_performance = 1
" let g:gruvbox_material_cursor = 'yellow'
" let g:gruvbox_material_ui_contrast = 'high'
" let g:gruvbox_material_show_eob = 0
" 
" colorscheme gruvbox-material

" colorscheme tokyonight

" let g:falcon_italic = 0
" let g:falcon_bold = 1
" let g:falcon_background = 1
" let g:falcon_inactive = 0
" colorscheme falcon

" let g:oceanic_next_terminal_bold = 1
" let g:oceanic_next_terminal_italic = 0
" colorscheme OceanicNext

hi Normal guibg=NONE ctermbg=NONE
hi LineNr ctermbg=NONE guibg=NONE 
" hi SignColumn guibg=NONE ctermbg=NONE
hi EndOfBuffer guibg=NONE ctermbg=NONE
hi Visual guibg=#2D1078  guifg=#f0f0f0 
hi Pmenu guibg=#002538
hi CursorLineNr guibg=#222222 guifg=#5FAFD7

" #2D1078
" guifg=#5FAFD7 
" CursorLineNr


" COMPLETION
" Avoid showing message extra message when using completion
" let g:completion_matching_strategy_list=['exact', 'substring', 'fuzzy']

let g:python3_host_prog="/usr/bin/python"

let g:vim_json_conceal=0

" NVIM TREE

" let g:nvim_tree_side = 'left' "left by default
" let g:nvim_tree_width = 30 "30 by default, can be width_in_columns or 'width_in_percent%'
let g:nvim_tree_ignore = [ '.git', 'node_modules', '.cache', '.dist' ] "empty by default
" let g:nvim_tree_gitignore = 1 "0 by default
" let g:nvim_tree_auto_open = 1 "0 by default, opens the tree when typing `vim $DIR` or `vim`
" let g:nvim_tree_auto_ignore_ft = [ 'startify'] "empty by default, don't auto open tree on specific filetypes.
" let g:nvim_tree_quit_on_open = 0 "0 by default, closes the tree when you open a file
" let g:nvim_tree_follow = 1 "0 by default, this option allows the cursor to be updated when entering a buffer
" let g:nvim_tree_follow_update_path = 1 "0 by default, will update the path of the current dir if the file is not inside the tree.  Default is 0

" let g:nvim_tree_indent_markers = 1 "0 by default, this option shows indent markers when folders are open
" let g:nvim_tree_hide_dotfiles = 0 "0 by default, this option hides files and folders starting with a dot `.`
let g:nvim_tree_git_hl = 1 "0 by default, will enable file highlight for git attributes (can be used without the icons).
let g:nvim_tree_highlight_opened_files = 1 "0 by default, will enable folder and file icon highlight for opened files/directories.
" let g:nvim_tree_root_folder_modifier = ':~' "This is the default. See :help filename-modifiers for more options
" let g:nvim_tree_tab_open = 1 "0 by default, will open the tree when entering a new tab and the tree was previously open
" let g:nvim_tree_auto_resize = 0 "1 by default, will resize the tree to its saved width when opening a file
" let g:nvim_tree_add_trailing = 1 "0 by default, append a trailing slash to folder names
" let g:nvim_tree_group_empty = 1 " 0 by default, compact folders that only contain a single folder into one node in the file tree
" let g:nvim_tree_lsp_diagnostics = 1 "0 by default, will show lsp diagnostics in the signcolumn. See :help nvim_tree_lsp_diagnostics
" let g:nvim_tree_disable_window_picker = 1 "0 by default, will disable the window picker.
" let g:nvim_tree_hijack_cursor = 0 "1 by default, when moving cursor in the tree, will position the cursor at the start of the file on the current line
let g:nvim_tree_icon_padding = '  ' "one space by default, used for rendering the space between the icon and the filename. Use with caution, it could break rendering if you set an empty string depending on your font.
" let g:nvim_tree_symlink_arrow = ' >> ' " defaults to ' ➛ '. used as a separator between symlinks' source and target.
" let g:nvim_tree_respect_buf_cwd = 1 "0 by default, will change cwd of nvim-tree to that of new buffer's when opening nvim-tree.
" let g:nvim_tree_refresh_wait = 100 "1000 by default, control how often the tree can be refreshed, 1000 means the tree can be refresh once per 1000ms.
let g:nvim_tree_window_picker_exclude = {
            \   'filetype': [
                \     'notify',
                \     'packer',
                \     'qf'
                \   ],
                \   'buftype': [
                    \     'terminal'
                    \   ]
                    \ }
" Dictionary of buffer option names mapped to a list of option values that
" indicates to the window picker that the buffer's window should not be
" selectable.
let g:nvim_tree_special_files = { 'README.md': 1, 'Makefile': 1, 'MAKEFILE': 1 } " List of filenames that gets highlighted with NvimTreeSpecialFile
let g:nvim_tree_show_icons = {
            \ 'git': 1,
            \ 'folders': 1,
            \ 'files': 1,
            \ 'folder_arrows': 0,
            \ }
"If 0, do not show the icons for one of 'git' 'folder' and 'files'
"1 by default, notice that if 'files' is 1, it will only display
"if nvim-web-devicons is installed and on your runtimepath.
"if folder is 1, you can also tell folder_arrows 1 to show small arrows next to the folder icons.
"but this will not work when you set indent_markers (because of UI conflict)

" default will show icon by default if no icon is provided
" default shows no icon by default
let g:nvim_tree_icons = {  'default': '' ,
            \ 'symlink': '',
            \ 'git': {
                \   'unstaged': "✗",
                \   'staged': "✓",
                \   'unmerged': "",
                \   'renamed': "➜",
                \   'untracked': "★",
                \   'deleted': "",
                \   'ignored': "◌"
                \   },
                \ 'folder': {
                    \   'arrow_open': "",
                    \   'arrow_closed': "",
                    \   'default': "",
                    \   'open': "",
                    \   'empty': "",
                    \   'empty_open': "",
                    \   'symlink': "",
                    \   'symlink_open': "",
                    \   },
                    \   'lsp': {
                        \     'hint': "",
                        \     'info': "",
                        \     'warning': "",
                        \     'error': "",
                        \   }
                        \ }
" a list of groups can be found at `:help nvim_tree_highlight`
" highlight NvimTreeFolderIcon guibg=blue

" AUTOCOMMANDS

au BufNewFile,BufRead *.tsx set filetype=typescriptreact

aug highlight_yank
    au!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=200}
aug END

aug format_options
    " do not insert comment in new line
    au BufNewFile,BufRead,BufEnter * setlocal formatoptions-=ro
aug END

" aug Neoformat
"     au BufWritePre *.js,*.ts,*.tsx,*.json,*.css,*.html,*.graphql Neoformat prettier
"     au BufWritePre * Neoformat
" aug END

" aug Formatter
"     " au!
"     au BufWritePost *.js,*.ts,*.tsx,*.json,*.css,*.html,*.graphql,*.lua,*.rs FormatWrite
" aug END

aug run
    " au Filetype javascript,typescript nnoremap <silent> <leader>r :sp<CR> :term deno run %<CR> :startinsert<CR>
    " au Filetype typescript nnoremap <silent> <leader>r :vsp<CR> :term deno run %<CR> :startinsert<CR>
    au Filetype lua nnoremap <silent> <leader>r <cmd>term lua %<cr> <cmd>startinsert<cr> 
    " au Filetype lua nnoremap <silent> <leader>r <cmd>!lua %<cr>
    au Filetype rust nnoremap <silent> <leader>r <cmd>term cargo run<cr> <cmd>startinsert<cr>
aug END

" aug floaterm
"     au Filetype floaterm hi Normal guibg=NONE ctermbg=NONE
" aug END

" aug cursorline
"     au InsertEnter * set nocul
"     au InsertLeave * set cul
" aug END

let g:startify_bookmarks = [ {'v': '~/.config/nvim/init.vim'},
            \{'l': '~/.config/nvim/lua/plugins.lua'} ,
            \{'i':'~/.i3/config'},
            \{'z':'~/.config/zsh/.zshrc' },
            \{'p':'~/.config/polybar/config'}
            \]

let g:startify_files_number=5
" let g:startify_files_number =
" let g:startify_commands =

" returns all modified files of the current git repo
" `2>/dev/null` makes the command fail quietly, so that when we are not
" in a git repo, the list will be empty
function! s:gitModified()
    let files = systemlist('git ls-files -m 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction

" same as above, but show untracked files respecting .gitignore
function! s:gitUntracked()
    let files = systemlist('git ls-files -o --exclude-standard 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction

let g:startify_lists = [
            \ { 'type': 'bookmarks', 'header': ['   bookmarks']      },
            \ { 'type': function('s:gitModified'),  'header': ['   git modified']},
            \ { 'type': function('s:gitUntracked'), 'header': ['   git untracked']},
            \ ]


" \ { 'type': 'commands',  'header': ['   Commands']       },
" \ { 'type': 'sessions',  'header': ['   Sessions']       },
" \ { 'type': 'files',     'header': ['   MRU']            },
" \ { 'type': function('s:foobar'), 'header': ['foo', ' and', '  bar'] },
" \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },

let g:ascii = [
            \ '       ____   ___   ____   __  __  __  ___ ___  ',
            \ '      / __ \ / _ \ / __ \ | | / / / / / __  __ \',
            \ '     / / / //  __ / /_/ / | |/ / / / / / / / / /',
            \ '    /_/ /_/ \___/ \____/  |___/ /_/ /_/ /_/ /_/ ',
            \ ]

" let g:startify_custom_header = g:ascii + startify#fortune#boxed()
" let g:startify_custom_header =
"             \   'startify#pad(g:ascii + startify#fortune#boxed())'
" let g:startify_custom_header = startify#center(g:ascii) + startify#center(startify#fortune#boxed())
let g:startify_custom_header = startify#center(startify#fortune#boxed())


" TABLINE

let g:tabline_show_devicons = 0
let g:tabline_show_filename_only = 1

" PLUGINS LUA SETUP

lua require('plugins')

" KEYMAPS

let mapleader = "\<Space>"

nnoremap <Space> <NOP>

inoremap <c-c> <esc>
vnoremap <c-c> <esc>
nnoremap <c-c> <esc>

" nnoremap <cmd>w <cmd>w<cmd>e
nnoremap <leader>S <cmd>Startify<cr>

" nvim-tree
nnoremap <leader>n <cmd> NvimTreeToggle  <CR>
nnoremap <leader>m <cmd> NvimTreeFocus  <CR>
" nnoremap <leader>tr <cmd> NvimTreeRefresh <CR>
" nnoremap <leader>n :NvimTreeFindFile<CR>
" NvimTreeOpen, NvimTreeClose and NvimTreeFocus are also available if you need them

" telescope
" nnoremap <silent> <C-p> <cmd>Telescope find_files theme=get_dropdown<cr>
nnoremap <leader>f <cmd>Telescope find_files<cr>
nnoremap <leader>b <cmd>Telescope buffers<cr>
nnoremap <leader>tb <cmd>Telescope file_browser<cr>
nnoremap <leader>cs <cmd>Telescope colorscheme<cr>
nnoremap <leader>lg <cmd>Telescope live_grep<cr>

" nnoremap <leader>tt <cmd>FloatermToggle<cr>
" nnoremap <leader>tn <cmd>FloatermNew<cr>


nnoremap <leader>gp <cmd>FormatWrite<cr>

" buffers
" nnoremap <silent> <Tab> :bnext<cr>
" nnoremap <silent> <S-Tab> :bprevious<cr>
" nnoremap <leader>x <cmd> bd <cr>

" tabline
nnoremap <Tab> <cmd>TablineBufferNext<cr>
nnoremap <S-Tab> <cmd>TablineBufferPrevious<cr>

" lsp
nnoremap <leader>- <cmd>TroubleToggle <cr>
nnoremap <leader>ld <cmd>lua vim.lsp.diagnostic.show_line_diagnostics() <cr>
nnoremap <leader>d <cmd>lua vim.lsp.buf.definition() <cr>
nnoremap <leader>h <cmd>lua vim.lsp.buf.hover() <cr>
nnoremap <leader>rs <cmd>lua require('rest-nvim').run() <cr>
nnoremap <leader>rn <cmd>lua vim.lsp.buf.rename() <cr>

nnoremap <leader>/ :CommentToggle<cr>
vnoremap <leader>/ :'<,'>CommentToggle<cr>gv

" using system clipboard
nnoremap <leader>y "+y
nnoremap <leader>Y "+y$
nnoremap <leader>p "+p
vnoremap <leader>y "+y
nnoremap <leader>Y "+y$
vnoremap <leader>p "+p

tnoremap <C-[> <C-\><C-N>

nnoremap Y y$
map q: <Nop>
nnoremap Q <nop>

" moving text
" vnoremap <silent> J :m '>+1<CR>gv=gv
" vnoremap <silent> K :m '<-2<CR>gv=gv
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
