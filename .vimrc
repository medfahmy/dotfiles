set nu
"set relativenumber

set title
set ruler 

set showcmd

syntax on
"colorscheme monokai 
"colorscheme vimvscode 
set guicursor=
set tabstop=2 softtabstop=2
set shiftwidth=2
"set expandtab
set smartindent
set hidden
set noerrorbells
set nowrap
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
	Plug 'neoclide/coc.nvim',  {'branch':'release'}
	Plug 'scrooloose/nerdtree'
	Plug 'Xuyuanp/nerdtree-git-plugin'
	Plug 'airblade/vim-gitgutter'
	Plug 'ryanoasis/vim-devicons'
	Plug 'scrooloose/nerdcommenter'
	Plug 'HerringtonDerkholme/yats.vim'
	

call plug#end()

colorscheme gruvbox
set background=dark

"Plug 'ayu-theme/ayu.vim'
"set termguicolors
"let ayucolor="dark"
"colorscheme ayu

