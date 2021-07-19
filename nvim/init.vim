syntax on
set nu
set relativenumber
set laststatus=2
set statusline=%F
set mouse+=a
set ruler 
set showcmd
"set guicursor=
set tabstop=2 softtabstop=2
set shiftwidth=2
"set expandtab
set smartindent
set hidden
set nohlsearch
"case insensitive search
set ignorecase
set smartcase
set autoread
set noerrorbells
set wrap
set incsearch
set scrolloff=8
set signcolumn=yes
set colorcolumn=80 
set termguicolors
set noswapfile
set re=0
set conceallevel=1
set clipboard=unnamedplus

set re=0

"Plugins
call plug#begin('~/.vim/plugged')
	Plug 'gruvbox-community/gruvbox'
	Plug 'nvim-lua/popup.nvim'
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim'
	Plug 'jiangmiao/auto-pairs'
	Plug 'neovim/nvim-lspconfig'
	Plug 'airblade/vim-gitgutter' "git signcolumn 
	Plug 'prettier/vim-prettier', {'do':'yarn install'}
	Plug 'rust-lang/rust.vim'
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	Plug 'neovimhaskell/haskell-vim'
	"Plug 'alx741/vim-hindent'
	Plug 'alx741/vim-stylishask'
	Plug 'neovim/nvim-lspconfig'
	"Plug 'nvim-lua/completion-nvim'

	call plug#end()


"autocmd BufEnter * lua require'completion'.on_attach()

lua << EOF

require'lspconfig'.tsserver.setup{}

require'lspconfig'.hls.setup{}

require('telescope').setup{
	defaults = {
		prompt_prefix =">>"
	}
}
EOF

syntax enable
filetype plugin indent on
filetype plugin on

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

"Colorscheme
let g:gruvbox_contrast_dark='hard' 
colorscheme gruvbox
"set background=dark


"lua require('lualine').setup()
"options = {theme = 'gruvbox'}

"Remaps
let mapleader=" "
nnoremap <C-p> :Prettier <CR>
nnoremap <C-f> <cmd>Telescope find_files<cr>

"Netrw
let g:netrw_banner = 0
let g:netrw_liststyle = 3
"let g:netrw_browse_split = 4
let g:netrw_winsize = 20
