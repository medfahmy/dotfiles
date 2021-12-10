-- :help lua-stdlib :help lua-vim
-- :lua print(vim.inspect(vim))
-- vim.inspect : pretty-print lua objects
-- vim.regex: use Vim regexes from Lua
-- vim.api: module that exposes API functions (the same API used by remote plugins)
-- vim.loop: module that exposes the functionality of Neovim's event-loop (using LibUV)
-- vim.lsp: module that controls the built-in LSP client
-- vim.treesitter: module that exposes the functionality of the tree-sitter library

vim.g.mapleader = ' '
vim.g.snippets = 'luasnip'

require'options'
require'plugins'
require'colorscheme'
require'keymaps'
require'autocmds'
require'_telescope'
require'treesitter'
require'tree'
require'lsp'
require'_cmp'
require'_lualine'
