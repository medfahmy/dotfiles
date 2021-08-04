" plugins
call plug#begin('~/.vim/plugged')

	Plug 'gruvbox-community/gruvbox'

	Plug 'nvim-lua/popup.nvim'
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim'
  
	Plug 'tpope/vim-commentary'

	Plug 'jiangmiao/auto-pairs'
  
	Plug 'neovim/nvim-lspconfig'
	Plug 'nvim-lua/completion-nvim'
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'folke/trouble.nvim'
  Plug 'folke/lsp-colors.nvim'

	Plug 'airblade/vim-gitgutter' "git signcolumn 


	Plug 'rust-lang/rust.vim'

	Plug 'neovimhaskell/haskell-vim'
	Plug 'alx741/vim-hindent'
	"Plug 'alx741/vim-stylishask'
  
	Plug 'jparise/vim-graphql'
  
  Plug 'leafgarland/typescript-vim'
  Plug 'pangloss/vim-javascript'
	Plug 'prettier/vim-prettier', {'do':'yarn install'}
  Plug 'maxmellon/vim-jsx-pretty'
	Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

  Plug 'hoob3rt/lualine.nvim'
  Plug 'arkav/lualine-lsp-progress'
  Plug 'voldikss/vim-floaterm'
  Plug 'kyazdani42/nvim-tree.lua'
  Plug 'romgrk/barbar.nvim'

	call plug#end()
  


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







syntax enable
filetype plugin indent on
filetype plugin on


let g:gruvbox_contrast_dark='dark' 
let g:gruvbox_invert_selection='0'
colorscheme gruvbox
set background=dark
hi Normal guibg=NONE ctermbg=NONE
hi MatchParen cterm=none ctermbg=green ctermfg=blue



" autocommands

autocmd BufEnter * lua require'completion'.on_attach()

" highlight yanked text
augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=100}
augroup END

"autocmd InsertEnter * set cul
"autocmd InsertLeave * set nocul


let g:javascript_plugin_jsdoc = 1

" nvim tree
let g:nvim_tree_ignore = [ '.git', 'node_modules', '.cache' ]
let g:nvim_tree_highlight_opened_files = 1
let g:nvim_tree_tab_open = 1
let g:nvim_tree_group_empty = 1
let g:nvim_tree_auto_open = 1 " open tree when file not specified
let g:nvim_tree_quit_on_open = 1
let g:nvim_tree_show_icons = {
      \ 'git': 0,
      \ 'folders': 0,
      \ 'files': 0,
      \ 'folder_arrows': 1,
      \ }







set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

let g:completion_matching_strategy_list=['exact', 'substring', 'fuzzy']

"By default auto popup is enabled, turn it off by
"let g:completion_enable_auto_popup = 0

"Prettier on save
let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0



let g:rustfmt_autosave = 1




"mappings

let mapleader = " "

nnoremap <silent> <C-p> <cmd>Telescope find_files theme=get_dropdown<cr>

"nnoremap <C-n> :bnext<CR>
"nnoremap <C-p> :bprevious<CR>
nnoremap <silent> <Tab> :bnext<CR>
nnoremap <silent> <S-Tab> :bprevious<CR>

vnoremap ; :
nnoremap ; :

nnoremap <silent> - <cmd>TroubleToggle<cr>


nnoremap Y y$
map q: <Nop>
nnoremap Q <nop>
"Autocomplete
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
imap <tab> <Plug>(completion_smart_tab)
imap <s-tab> <Plug>(completion_smart_s_tab)
nnoremap <silent> <C-n> :NvimTreeToggle<CR>

" moving text
vnoremap <silent> J :m '>+1<CR>gv=gv
vnoremap <silent> K :m '<-2<CR>gv=gv
inoremap <C-j> <esc>:m .+1<CR>==
inoremap <C-k> <esc>:m .-2<CR>==
nnoremap <leader>j :m .+1<CR>==
nnoremap <leader>k :m .-2<CR>==


" indenting selection while staying in visual mode
vnoremap < <gv
vnoremap > >gv

" keeping it centered
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z


" " undo break points
" inoremap , ,<c-g>u
" inoremap . .<c-g>u
" inoremap ! !<c-g>u
" inoremap ? ?<c-g>u
" inoremap ( (<c-g>u
" inoremap ) )<c-g>u
" inoremap { {<c-g>u
" inoremap } }<c-g>u
" inoremap [ [<c-g>u
" inoremap ] ]<c-g>u
" inoremap < <<c-g>u
" inoremap > ><c-g>u

" jumplist mutations
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'

vnoremap " <esc>`>a"<esc>`<i"<esc>
vnoremap ( <esc>`>a)<esc>`<i(<esc>
vnoremap [ <esc>`>a]<esc>`<i[<esc>
vnoremap ' <esc>`>a'<esc>`<i'<esc>
vnoremap { <esc>`>a}<esc>`<i{<esc>

" Move to previous/next
"nnoremap <silent>    <A-,> :BufferPrevious<CR>
"nnoremap <silent>    <A-.> :BufferNext<CR>
" Re-order to previous/next
nnoremap <silent>    <A-<> :BufferMovePrevious<CR>
nnoremap <silent>    <A->> :BufferMoveNext<CR>
" Goto buffer in position...
nnoremap <silent>    <A-1> :BufferGoto 1<CR>
nnoremap <silent>    <A-2> :BufferGoto 2<CR>
nnoremap <silent>    <A-3> :BufferGoto 3<CR>
nnoremap <silent>    <A-4> :BufferGoto 4<CR>
nnoremap <silent>    <A-5> :BufferGoto 5<CR>
nnoremap <silent>    <A-6> :BufferGoto 6<CR>
nnoremap <silent>    <A-7> :BufferGoto 7<CR>
nnoremap <silent>    <A-8> :BufferGoto 8<CR>
nnoremap <silent>    <A-9> :BufferLast<CR>
" Close buffer
nnoremap <silent>    <leader>c :BufferClose<CR>

lua << EOF

-- Color table for highlights
local colors = {
  bg = '#202328',
  fg = '#bbc2cf',
  yellow = '#fabd2f',
  cyan = '#008080',
  darkblue = '#081633',
  green = '#b8bb26',
  orange = '#fe8019',
  violet = '#d3869b',
  magenta = '#c678dd',
  blue = '#51afef',
  red = '#fb4934'
}


-- lualine

local custom_gruvbox = require'lualine.themes.gruvbox'
-- Change the background of lualine_c section for normal mode
custom_gruvbox.normal.a.bg = colors.yellow -- rgb colors are supported
custom_gruvbox.insert.a.bg = colors.red -- rgb colors are supported
custom_gruvbox.visual.a.bg = colors.orange -- rgb colors are supported
custom_gruvbox.command.a.bg = colors.green -- rgb colors are supported

require'lualine'.setup {
  options = {
    icons_enabled = true,
    theme = custom_gruvbox,
    -- section_separators = '',
    -- component_separators = '|',
    component_separators = {'', ''},
    section_separators = {'', ''},
    disabled_filetypes = {}
    },
sections = {
  lualine_a = {'mode' },
  lualine_b ={
  'branch',
    {
      'filename',
      path=1
    },
  'diff'
  },

  lualine_x = {
    {
        'diagnostics',
        sources = {'nvim_lsp'},
        symbols = {error = '', warn = '', info = ''},
        color_error = colors.red,
        color_warn = colors.yellow,
        color_info = colors.cyan
    },
    function()
      local msg = 'no lsp'
      local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
      local clients = vim.lsp.get_active_clients()
      if next(clients) == nil then return msg end
        for _, client in ipairs(clients) do
          local filetypes = client.config.filetypes
          if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            return client.name
          end
        end
        return msg
      end,
      color = {fg = '#ffffff'}
      },

    lualine_y = {
      {
      'filetype',
      colored=true
      }
      },

    lualine_z = {'location'}
    },
  tabline={},
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
    },
  extensions = {}
  }


-- barbar
vim.g.bufferline = {
  -- Enable/disable animations
  animation = false,

  -- Enable/disable auto-hiding the tab bar when there is a single buffer
  auto_hide = false,

  -- Enable/disable current/total tabpages indicator (top right corner)
  tabpages = true,

  -- Enable/disable close button
  closable = true,

  -- Enables/disable clickable tabs
  --  - left-click: go to buffer
  --  - middle-click: delete buffer
  clickable = true,

  -- Excludes buffers from the tabline
  -- exclude_ft = ['javascript'],
  -- exclude_name = ['package.json'],

  -- Enable/disable icons
  -- if set to 'numbers', will show buffer index in the tabline
  -- if set to 'both', will show buffer index and icons in the tabline
  icons = false,

  -- If set, the icon color will follow its corresponding buffer
  -- highlight group. By default, the Buffer*Icon group is linked to the
  -- Buffer* group (see Highlighting below). Otherwise, it will take its
  -- default value as defined by devicons.
  icon_custom_colors = false,

  -- Configure icons on the bufferline.
  icon_separator_active = '',
  icon_separator_inactive = '',
  -- component_separators = {'', ''},
  -- section_separators = {'', ''},
  icon_close_tab = 'x',
  icon_close_tab_modified = 'ø',

  -- Sets the maximum padding width with which to surround each tab
  maximum_padding = 1,

  -- Sets the maximum buffer name length.
  maximum_length = 30,

  -- If set, the letters for each buffer in buffer-pick mode will be
  -- assigned based on their name. Otherwise or in case all letters are
  -- already assigned, the behavior is to assign letters in order of
  -- usability (see order below)
  semantic_letters = true,

  -- New buffer letters are assigned in this order. This order is
  -- optimal for the qwerty keyboard layout but might need adjustement
  -- for other layouts.
  letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',

  -- Sets the name of unnamed buffers. By default format is "[Buffer X]"
  -- where X is the buffer number. But only a static string is accepted here.
  no_name_title = "untitled",
}

require'lspconfig'.tsserver.setup{}
require'lspconfig'.graphql.setup{

}
require'lspconfig'.hls.setup{
	on_attach = require'completion'.on_attach
}
require'lspconfig'.vimls.setup{}
require'lspconfig'.rust_analyzer.setup{}
require('telescope').setup{
	defaults = {
		prompt_prefix ="> "
	}
}

require'lspconfig'.gopls.setup{}
require'lspconfig'.jsonls.setup {
    commands = {
      Format = {
        function()
          vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
        end
      }
    }
}


local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspconfig'.cssls.setup {
  capabilities = capabilities,
}

require'lspconfig'.html.setup {
  capabilities = capabilities,
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = true,
        --update_in_insert=true,
        signs=true
    }
)

require("trouble").setup {}


require'nvim-treesitter.configs'.setup {
  autotag = {
    enable = true,
  }
}
EOF 
