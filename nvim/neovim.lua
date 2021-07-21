require'lspconfig'.tsserver.setup{}

require'lspconfig'.hls.setup{
	on_attach = require'completion'.on_attach
}

require('telescope').setup{
	defaults = {
		prompt_prefix =">>  "
	}
}
