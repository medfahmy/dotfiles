"General
set nu
set relativenumber
set laststatus=2
set statusline=%F

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
set wrap
set ignorecase
set smartcase
set incsearch
set scrolloff=8
set signcolumn=yes
"set noswapfile
syntax enable

"Plugins
call plug#begin('~/.vim/plugged')
	Plug 'gruvbox-community/gruvbox'
	Plug 'jiangmiao/auto-pairs'
	Plug 'leafgarland/typescript-vim'
	"Plug 'mbbill/undotree'
	"Plug 'neoclide/coc.nvim',  {'branch':'release'}
	"Plug 'preservim/nerdtree'
	"Plug 'Xuyuanp/nerdtree-git-plugin'
	Plug 'airblade/vim-gitgutter'
	"Plug 'ryanoasis/vim-devicons'
	Plug 'scrooloose/nerdcommenter'
	Plug 'HerringtonDarkholme/yats.vim'
	"Plug 'ayu-theme/ayu.vim'
	"Plug 'ptzz/lf.vim'
	"Plug 'voldikss/vim-floaterm'
	Plug 'prettier/vim-prettier', {'do':'yarn install'}
	"Plug 'google/vim-maktaba'
	"Plug 'google/vim-codefmt'
	"Plug 'google/vim-glaive'
	Plug 'junegunn/fzf', {'do': { -> fzf#install() }}
	Plug 'junegunn/fzf.vim'
	call plug#end()
	
"call glaive#Install()

"Glaive codefmt plugin[mappings]
"Glaive codefmt google_java_executable="java -jar /path/to/google-java-format-VERSION-all-deps.jar"

"Colorscheme
let g:gruvbox_contrast_dark='hard' 
colorscheme gruvbox
set background=dark
"colorscheme darkgit
"set termguicolors
"let ayucolor="dark"
"colorscheme ayu
"colorscheme monokai 
"colorscheme vimvscode 



"Remaps
"let mapleader=""
"nnoremap <C-n> :NERDTree<CR>
nnoremap <C-p> :Prettier <CR>
nnoremap <C-f> :Files <CR>
inoremap ² <Esc>
vnoremap ² <Esc>
nnoremap à 0


"augroup autoformat_settings
"  autocmd FileType bzl AutoFormatBuffer buildifier
"  autocmd FileType c,cpp,proto,javascript,arduino AutoFormatBuffer clang-format
"  autocmd FileType dart AutoFormatBuffer dartfmt
"  autocmd FileType go AutoFormatBuffer gofmt
"  autocmd FileType gn AutoFormatBuffer gn
"  autocmd FileType html,css,sass,scss,less,json AutoFormatBuffer js-beautify
"  autocmd FileType java AutoFormatBuffer google-java-format
"  autocmd FileType python AutoFormatBuffer yapf
"  " Alternative: autocmd FileType python AutoFormatBuffer autopep8
"  autocmd FileType rust AutoFormatBuffer rustfmt
"  autocmd FileType vue AutoFormatBuffer prettier
"augroup END

"Netrw
"let g:netrw_banner = 0
"let g:netrw_liststyle = 3
"let g:netrw_browse_split = 4
"let g:netrw_winsize = 20
"
"function! OpenToRight()
"	:normal v
"	let g:path=expand('%:p')
"	execute 'q!'
"	execute 'belowright vnew' g:path
"	:normal <C-w>l
"endfunction
"
"function! OpenBelow()
"	:normal v
"	let g:path=expand('%:p')
"	execute 'q!'
"	execute 'belowright new' g:path
"	:normal <C-w>l
"endfunction
"
"function! OpenTab()
"	:normal v
"	let g:path=expand('%:p')
"	execute 'q!'
"	execute 'tabedit' g:path
"	:normal <C-w>l
"endfunction
"
"function! NetrwMappings()
"		" Hack fix to make ctrl-l work properly
"		noremap <buffer> <A-l> <C-w>l
"		noremap <buffer> <C-l> <C-w>l
"		noremap <silent> <A-f> :call ToggleNetrw()<CR>
"		noremap <buffer> V :call OpenToRight()<cr>
"		noremap <buffer> H :call OpenBelow()<cr>
"		noremap <buffer> T :call OpenTab()<cr>
"endfunction
"
"augroup netrw_mappings
"		autocmd!
"		autocmd filetype netrw call NetrwMappings()
"augroup END
"
"" Allow for netrw to be toggled
"function! ToggleNetrw()
"		if g:NetrwIsOpen
"				let i = bufnr("$")
"				while (i >= 1)
"						if (getbufvar(i, "&filetype") == "netrw")
"								silent exe "bwipeout " . i
"						endif
"						let i-=1
"				endwhile
"				let g:NetrwIsOpen=0
"		else
"				let g:NetrwIsOpen=1
"				silent Lexplore
"		endif
"endfunction
"
"" Check before opening buffer on any file
"function! NetrwOnBufferOpen()
"	if exists('b:noNetrw')
"			return
"	endif
"	call ToggleNetrw()
"endfun
"
"" Close Netrw if it's the only buffer open
"autocmd WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&filetype") == "netrw" || &buftype == 'quickfix' |q|endif
"
"" Make netrw act like a project Draw
"augroup ProjectDrawer
"	autocmd!
"	" Don't open Netrw
"	autocmd VimEnter ~/.config/joplin/tmp/*,/tmp/calcurse*,~/.calcurse/notes/*,~/vimwiki/*,*/.git/COMMIT_EDITMSG let b:noNetrw=1
"	autocmd VimEnter * :call NetrwOnBufferOpen()
"augroup END
"
"let g:NetrwIsOpen=0
