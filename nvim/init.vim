" Plugins
call plug#begin('~/.vim/plugged')

  Plug 'morhetz/gruvbox'
  Plug 'sainnhe/gruvbox-material'
  " Plug 'Mofiqul/dracula.nvim'
  Plug 'dracula/vim', { 'as': 'dracula' }
  Plug 'dikiaap/minimalist'
  Plug 'phanviet/vim-monokai-pro'
  Plug 'mhartington/oceanic-next'
  Plug 'chriskempson/base16-vim'
  Plug 'sickill/vim-monokai'
  Plug 'jnurmine/Zenburn'
  Plug 'srcery-colors/srcery-vim'

  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'kyazdani42/nvim-web-devicons'

  Plug 'luukvbaal/stabilize.nvim'

  " Plug 'noib3/cokeline.nvim'
  Plug 'akinsho/bufferline.nvim'

  " Plug 'kyazdani42/nvim-tree.lua'

  Plug 'neovim/nvim-lspconfig'
  Plug 'kabouzeid/nvim-lspinstall'

  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'folke/trouble.nvim'
  Plug 'folke/lsp-colors.nvim'

  " Plug 'HerringtonDarkholme/yats.vim'
  " Plug 'leafgarland/typescript-vim'
  Plug 'peitalin/vim-jsx-typescript'
  Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'L3MON4D3/LuaSnip'
  Plug 'saadparwaiz1/cmp_luasnip'
  Plug 'onsails/lspkind-nvim'

  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-telescope/telescope-project.nvim'
  Plug 'nvim-telescope/telescope-fzy-native.nvim'
  Plug 'tami5/sqlite.lua'
  Plug 'nvim-telescope/telescope-frecency.nvim'

  " Plug 'sbdchd/neoformat'
  Plug 'mhartington/formatter.nvim'
  Plug 'terrortylor/nvim-comment'
  Plug 'hoob3rt/lualine.nvim'
  Plug 'kdheepak/tabline.nvim'
  Plug 'NTBBloodbath/rest.nvim'
  Plug 'windwp/nvim-ts-autotag'
  Plug 'windwp/nvim-autopairs'
  " Plug 'nvim-neorg/neorg'
  " Plug 'airblade/vim-gitgutter' "git signcolumn
  " Plug 'TimUntersberger/neogit'
  Plug 'norcalli/nvim-colorizer.lua'
  " Plug 'lukas-reineke/indent-blankline.nvim'

call plug#end()

" SETTINGS
set title
set nu
set relativenumber
" set numberwidth=4
"set laststatus=2
"set statusline=%F
set mouse+=a
set ruler
" set showcmd
set guicursor+=n-v-c-sm:blinkon0
set cursorline
set culopt=number
set shortmess+=c
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set smartindent
set hidden
set autoread 
set noerrorbells
set novisualbell
set wrap
set incsearch
set nohlsearch
set ignorecase
set smartcase
set scrolloff=8
set signcolumn=yes
" set colorcolumn=80
set termguicolors
set noswapfile
set re=0
set conceallevel=1
" set clipboard=unnamedplus
set noshowmode
set history=9000
set undolevels=2000
set undofile
" set timeoutlen=750
set lazyredraw
set showmatch
set splitbelow splitright
set guioptions-=e
set completeopt=menu,menuone,noselect

" file navigation
" set wildmenu
" set wildmode=list:lastused
set wildignorecase
set path+=**
set wildignore=.git,.hg,*.o,*.a,*.class,*.jar,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,*.pyc,*.pyo,**/cache/*,**/logs/*,**/target/*,*.hi,tags,**/dist/*,**/public/**/vendor/**,**/public/vendor/**,**/node_modules/**

syntax on
filetype plugin indent on

let g:vim_json_conceal=0


" COLORSCHEME

" set background=dark
" let g:gruvbox_material_palette = 'original'
" let g:gruvbox_material_background = 'hard'
" let g:gruvbox_material_enable_bold = 1
" let g:gruvbox_material_enable_italic = 1
" let g:gruvbox_material_disable_italic_comment = 1
" let g:gruvbox_material_transparent_background = 1
" let g:gruvbox_material_diagnostic_text_highlight = 1
" let g:gruvbox_material_diagnostic_line_highlight = 1
" let g:gruvbox_material_diagnostic_virtual_text = 'colored'
" let g:gruvbox_material_better_performance = 1
" let g:gruvbox_material_cursor = 'yellow'

" colorscheme gruvbox-material

colorscheme OceanicNext

hi Normal guibg=NONE
hi LineNr guibg=NONE guifg=#666666
hi SignColumn guibg=NONE guifg=NONE
hi EndOfBuffer guibg=NONE
hi Visual guibg=#444444  guifg=#f0f0f0 
hi Pmenu guibg=#222222
hi CursorLineNr guibg=NONE guifg=#fac863 

" #2D1078
" #fabd2f
" #5fafd7 
" #83a598 

" base 00: #1B2B34
" base 01: #343D46
" base 02: #4F5B66
" base 03: #65737E
" base 04: #A7ADBA
" base 05: #C0C5CE
" base 06: #CDD3DE
" base 07: #D8DEE9
" base 08: #EC5f67
" base 09: #F99157
" base 0A: #FAC863
" base 0B: #99C794
" base 0C: #5FB3B3
" base 0D: #6699CC
" base 0E: #C594C5
" base 0F: #AB7967


" AUTOCOMMANDS

" au BufNewFile,BufRead *.tsx set filetype=typescriptreact

aug highlight_yank
  au!
  au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=200}
aug END

aug format_options
  " do not insert comment in new line
  au BufNewFile,BufRead,BufEnter * setlocal formatoptions-=ro
aug END

au BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()


" PLUGINS LUA SETUP
lua require('plugins')


" KEYMAPS
let mapleader = "\<Space>"

nnoremap <Space> <NOP>

inoremap <c-c> <esc>
vnoremap <c-c> <esc>
nnoremap <c-c> <esc>

nnoremap <leader>o :%bd\|e#\|bd#<cr>

" telescope
nnoremap <leader>f <cmd>Telescope find_files<cr>
nnoremap <leader>b <cmd>Telescope buffers<cr>
nnoremap <leader>tb <cmd>Telescope file_browser<cr>
nnoremap <leader>cs <cmd>Telescope colorscheme<cr>
nnoremap <leader>lg <cmd>Telescope live_grep<cr>
" nnoremap <leader>tp <cmd>Telescope project<cr>
nnoremap <leader>tp <cmd>lua require'telescope'.extensions.project.project{ display_type = 'full'}<cr>
nnoremap <leader>ts <cmd>Telescope lsp_dynamic_workspace_symbols<cr>

nnoremap <leader>gp <cmd>FormatWrite<cr>

" nnoremap <leader>n <cmd>NvimTreeToggle<cr>

" buffers
nnoremap <silent> <Tab> :bnext<cr>
nnoremap <silent> <S-Tab> :bprevious<cr>
" nnoremap <leader>x <cmd> bd <cr>

" tabline
" nnoremap <Tab> <cmd>TablineBufferNext<cr>
" nnoremap <S-Tab> <cmd>TablineBufferPrevious<cr>

" lsp
nnoremap <leader>vd <cmd>lua vim.lsp.buf.definition() <cr>
nnoremap <leader>vi <cmd>lua vim.lsp.buf.implementation() <cr>
nnoremap <leader>vs <cmd>lua vim.lsp.buf.signature_help() <cr>
nnoremap <leader>vl <cmd>lua vim.lsp.diagnostic.show_line_diagnostics() <cr>
nnoremap <leader>vh <cmd>lua vim.lsp.buf.hover() <cr>
nnoremap <leader>vr <cmd>lua vim.lsp.buf.rename() <cr>
nnoremap <leader>vf <cmd>lua vim.lsp.buf.references() <cr>
nnoremap <leader>va <cmd>lua vim.lsp.buf.code_action() <cr>
nnoremap <leader>vn <cmd>lua vim.lsp.diagnostic.goto_next() <cr>

nnoremap <leader>- <cmd>TroubleToggle <cr>

nnoremap <leader>rs <cmd>lua require('rest-nvim').run() <cr>

nnoremap <silent> <leader>/ :CommentToggle<cr>
vnoremap <silent> <leader>/ :'<,'>CommentToggle<cr>

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
