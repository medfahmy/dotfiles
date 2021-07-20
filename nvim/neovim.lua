require'lspconfig'.tsserver.setup{}

require'lspconfig'.hls.setup{}

require('telescope').setup{
	defaults = {
		prompt_prefix =">>  "
	}
}
