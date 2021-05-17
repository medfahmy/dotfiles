set nu
"set relativenumber

set title
set ruler 

set showcmd

syntax on
"colorscheme monokai 
"colorscheme vimvscode 
set guicursor=
set tabstop=4 softtabstop=4
set shiftwidth=4
"set expandtab
set smartindent
set hidden
set noerrorbells
set wrap
set ignorecase
set smartcase
set incsearch
set scrolloff=8
set signcolumn=yes
set noswapfile

syntax enable

call plug#begin('~/.vim/plugged')
	Plug 'morhetz/gruvbox'
	Plug 'leafgarland/typescript-vim'
	Plug 'mbbill/undotree'
call plug#end()

colorscheme gruvbox
set background=dark

"Plug 'ayu-theme/ayu.vim'
"set termguicolors
"let ayucolor="dark"
"colorscheme ayu

