require('trouble').setup {
  icons = true
}

vim.lsp.handlers['textDocument/publishDiagnostics'] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = true,
      update_in_insert = true,
      underline = true,
      signs = true
    })

local capabilities = require('cmp_nvim_lsp')
  .update_capabilities(vim.lsp.protocol.make_client_capabilities())

require'lspconfig'.tsserver.setup {
  capabilities = capabilities
}

require'lspconfig'.svelte.setup{}

require'lspconfig'.pylsp.setup{}

-- require'lspconfig'.pyright.setup{}

-- require'lspconfig'.graphql.setup {
--     filetypes = {'graphql', 'graphqls'},
--     capabilities = capabilities
-- }
--
-- require'lspconfig'.hls.setup {
--     capabilities = capabilities
-- }
--
-- require'lspconfig'.vimls.setup {
--     capabilities = capabilities
-- }
--

require'lspconfig'.rust_analyzer.setup {
    capabilities = capabilities
}

require'lspconfig'.gopls.setup{}

-- require'lspconfig'.cssls.setup {
--   capabilities = capabilities
-- }

-- require'lspconfig'.html.setup {
--     capabilities = capabilities
-- }

-- require'lspconfig'.jsonls.setup {
--   commands = {
--     Format = {
--       function()
--         vim.lsp.buf.range_formatting({}, {0, 0}, {vim.fn.line('$'), 0})
--       end
--     }
--   },
--   capabilities = capabilities
-- }

vim.cmd([[
    nnoremap <leader>d <cmd>lua vim.lsp.buf.definition() <cr>
    nnoremap <leader>vi <cmd>lua vim.lsp.buf.implementation() <cr>
    nnoremap <leader>vs <cmd>lua vim.lsp.buf.signature_help() <cr>
    nnoremap <leader>l <cmd>lua vim.diagnostic.open_float() <cr>
    nnoremap <leader>h <cmd>lua vim.lsp.buf.hover() <cr>
    nnoremap <leader>vr <cmd>lua vim.lsp.buf.rename() <cr>
    nnoremap <leader>vf <cmd>lua vim.lsp.buf.references() <cr>
    nnoremap <leader>va <cmd>lua vim.lsp.buf.code_action() <cr>
    nnoremap <leader>vn <cmd>lua vim.lsp.diagnostic.goto_next() <cr>
]])
