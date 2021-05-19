"General
set nu
set relativenumber
set laststatus=2
set statusline=%F
set title
set ruler 
set showcmd
syntax on
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
"set noswapfile
syntax enable

"Plugins
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
	"Plug 'ayu-theme/ayu.vim'
call plug#end()

"Colorscheme
colorscheme gruvbox
set background=dark
"set termguicolors
"let ayucolor="dark"
"colorscheme ayu
"colorscheme monokai 
"colorscheme vimvscode 
