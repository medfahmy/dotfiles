" plugins
call plug#begin('~/.vim/plugged')
	Plug 'gruvbox-community/gruvbox'

	Plug 'nvim-lua/popup.nvim'
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim'

	"Plug 'jiangmiao/auto-pairs'
  
	Plug 'neovim/nvim-lspconfig'
	Plug 'nvim-lua/completion-nvim'
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'folke/trouble.nvim'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'folke/lsp-colors.nvim'

	Plug 'airblade/vim-gitgutter' "git signcolumn 

	Plug 'prettier/vim-prettier', {'do':'yarn install'}

	Plug 'rust-lang/rust.vim'

	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'

	Plug 'neovimhaskell/haskell-vim'
	Plug 'alx741/vim-hindent'
	"Plug 'alx741/vim-stylishask'
  "
	Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

	Plug 'jparise/vim-graphql'
  
	Plug 'luochen1990/rainbow'

  Plug 'leafgarland/typescript-vim'
  Plug 'maxmellon/vim-jsx-pretty'
  

	call plug#end()

" colorscheme
let g:gruvbox_contrast_dark='dark' 
let g:gruvbox_invert_selection='0'
colorscheme gruvbox
set background=dark
hi Normal guibg=NONE ctermbg=NONE
hi MatchParen cterm=none ctermbg=green ctermfg=blue


" settings
syntax on
set nu
set relativenumber
"set laststatus=2
"set statusline=%F
set mouse+=a "mouse support
set ruler 
set showcmd
set guicursor+=n-v-c:blinkon0
set cursorline
set shortmess+=c
set tabstop=2 
set softtabstop=2
set shiftwidth=2
set expandtab
set smartindent
set hidden
set autoread "auto read a file that changed on disk
set noerrorbells
set wrap "wrap long lines
set incsearch "incrementally highlight while typing search command
set nohlsearch "remove highlight after searching
set ignorecase "case insensitive search
set smartcase "case sensitive if capital 
set scrolloff=8
"set signcolumn=yes
"set colorcolumn=80 
set termguicolors
set noswapfile
set re=0
set conceallevel=1
set clipboard=unnamedplus "use system clipboard
set noshowmode "dont show mode on command line since lightline can show it
set history=9000
set undolevels=2000
set undofile
set wildmode=list:full            " Complete files like a shell.
set wildignore=.git,.hg,*.o,*.a,*.class,*.jar,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,*.pyc,*.pyo,**/cache/*,**/logs/*,**/target/*,*.hi,tags,**/dist/*,**/public/**/vendor/**,**/public/vendor/**,**/node_modules/**


"autocmd InsertEnter * set cul
"autocmd InsertLeave * set nocul

autocmd BufEnter * lua require'completion'.on_attach()




syntax enable
filetype plugin indent on
filetype plugin on

"Autocomplete
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"




set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

let g:completion_matching_strategy_list=['exact', 'substring', 'fuzzy']

"By default auto popup is enabled, turn it off by
"let g:completion_enable_auto_popup = 0

"Prettier on save
let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0

let g:haskell_enable_quantification = 1   
" to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      
" to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      
" to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 
" to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        
" to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  
" to enable highlighting of `static`
let g:haskell_backpack = 1                
" to enable highlighting of backpack keywords

let g:hindent_on_save = 1

let g:rustfmt_autosave = 1

let g:airline#extensions#tabline#enabled = 1


let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle
" Set completeopt to have a better completion experience

let g:rainbow#max_level = 16

let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]

autocmd FileType * RainbowToggle

"lua require('lualine').setup()
"options = {theme = 'gruvbox'}

"Remaps
nnoremap <C-f> <cmd>Telescope find_files<cr>
"nnoremap <C-n> :bnext<CR>
"nnoremap <C-p> :bprevious<CR>
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
nnoremap ; :
nnoremap - <cmd>TroubleToggle<cr>
nnoremap Y y$
map q: <Nop>
nnoremap Q <nop>

"Netrw
let g:netrw_banner = 0
let g:netrw_liststyle = 3
"let g:netrw_browse_split = 4
let g:netrw_winsize = 20

" lua
lua  << EOF
require'lspconfig'.tsserver.setup{}
require'lspconfig'.graphql.setup{}

require'lspconfig'.hls.setup{
	on_attach = require'completion'.on_attach
}

require('telescope').setup{
	defaults = {
		prompt_prefix =">>  "
	}
}
require("trouble").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }



vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false,
        --update_in_insert=true,
        signs=true

    }
)
EOF
