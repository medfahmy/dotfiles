" plugins
call plug#begin('~/.vim/plugged')
	Plug 'gruvbox-community/gruvbox'

	Plug 'nvim-lua/popup.nvim'
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim'
  
	Plug 'tpope/vim-commentary'

	"Plug 'jiangmiao/auto-pairs'
  
	Plug 'neovim/nvim-lspconfig'
	Plug 'nvim-lua/completion-nvim'
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'folke/trouble.nvim'
  Plug 'folke/lsp-colors.nvim'

	Plug 'airblade/vim-gitgutter' "git signcolumn 

	Plug 'prettier/vim-prettier', {'do':'yarn install'}

	Plug 'rust-lang/rust.vim'

	Plug 'neovimhaskell/haskell-vim'
	Plug 'alx741/vim-hindent'
	"Plug 'alx741/vim-stylishask'
  
	Plug 'jparise/vim-graphql'
  
  Plug 'leafgarland/typescript-vim'
  Plug 'maxmellon/vim-jsx-pretty'
	Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

  Plug 'hoob3rt/lualine.nvim'
  " If you want to have icons in your statusline choose one of these
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'arkav/lualine-lsp-progress'
  Plug 'voldikss/vim-floaterm'
  Plug 'kyazdani42/nvim-tree.lua'
  Plug 'romgrk/barbar.nvim'

	call plug#end()

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

" barbar
" NOTE: If barbar's option dict isn't created yet, create it
let bufferline = get(g:, 'bufferline', {})

" Enable/disable animations
let bufferline.animation = v:false

" Enable/disable auto-hiding the tab bar when there is a single buffer
let bufferline.auto_hide = v:false

" Enable/disable current/total tabpages indicator (top right corner)
let bufferline.tabpages = v:true

" Enable/disable close button
let bufferline.closable = v:false

" Enables/disable clickable tabs
"  - left-click: go to buffer
"  - middle-click: delete buffer
let bufferline.clickable = v:true

" Enable/disable icons
" if set to 'numbers', will show buffer index in the tabline
" if set to 'both', will show buffer index and icons in the tabline
let bufferline.icons = v:false


" Sets the maximum padding width with which to surround each tab.
let bufferline.maximum_padding = 2

" Sets the maximum buffer name length.
let bufferline.maximum_length = 30




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





syntax enable
filetype plugin indent on
filetype plugin on


let g:gruvbox_contrast_dark='dark' 
let g:gruvbox_invert_selection='0'
colorscheme gruvbox
set background=dark
hi Normal guibg=NONE ctermbg=NONE
hi MatchParen cterm=none ctermbg=green ctermfg=blue



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




"Remaps

nnoremap <C-f> <cmd>Telescope find_files theme=get_dropdown<cr>
"nnoremap <C-n> :bnext<CR>
"nnoremap <C-p> :bprevious<CR>
nnoremap <Tab> :BufferNext<CR>
nnoremap <S-Tab> :BufferPrevious<CR>
nnoremap ; :
vnoremap ; :
nnoremap - <cmd>TroubleToggle<cr>
nnoremap Y y$
map q: <Nop>
nnoremap Q <nop>
"Autocomplete
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
imap <tab> <Plug>(completion_smart_tab)
imap <s-tab> <Plug>(completion_smart_s_tab)
nnoremap <C-n> :NvimTreeToggle<CR>


" Lua
lua  << EOF

-- Color table for highlights
local colors = {
  bg = '#202328',
  fg = '#bbc2cf',
  yellow = '#ECBE7B',
  cyan = '#008080',
  darkblue = '#081633',
  green = '#98be65',
  orange = '#FF8800',
  violet = '#a9a1e1',
  magenta = '#c678dd',
  blue = '#51afef',
  red = '#ec5f67'
}

require'lualine'.setup {
  options = {
    icons_enabled = true,
    theme = 'gruvbox',
    component_separators = {'', ''},
    section_separators = {'', ''},
    disabled_filetypes = {}
  },
sections = {
  lualine_a = {'mode'},


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

require'lspconfig'.tsserver.setup{}
require'lspconfig'.graphql.setup{}
require'lspconfig'.hls.setup{
	on_attach = require'completion'.on_attach
}
require('telescope').setup{
	defaults = {
		prompt_prefix ="> "
	}
}
require("trouble").setup {}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspconfig'.cssls.setup {
  capabilities = capabilities,
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspconfig'.html.setup {
  capabilities = capabilities,
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false,
        --update_in_insert=true,
        signs=true

    }
)




EOF


autocmd BufEnter * lua require'completion'.on_attach()
