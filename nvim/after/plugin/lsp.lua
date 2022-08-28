local lspconfig = require("lspconfig")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local on_attach = function(client, bufnr)
    local nnoremap = require("keymap").nnoremap

    nnoremap("<space>d", vim.lsp.buf.definition)
    nnoremap("<space>h", vim.lsp.buf.hover)
    nnoremap("<space>e", vim.diagnostic.open_float)
    nnoremap("<space>lc", vim.lsp.buf.declaration)
    nnoremap("<space>lr", vim.lsp.buf.rename)
    nnoremap("<space>la", vim.lsp.buf.code_action)
    nnoremap("<space>le", vim.lsp.buf.references)
    nnoremap("<space>lf", vim.lsp.buf.formatting)

    nnoremap("<space>-", "<cmd>TroubleToggle<cr>")
end

local config = {
    on_attach = on_attach,
    capabilities = capabilities,
    handlers = {
        ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
            virtual_text = false,
        }),
    },
}

local lsps = { "tsserver", "cssls", "rust_analyzer", "pyright" }

for _, lsp in ipairs(lsps) do
    lspconfig[lsp].setup(config)
end

lspconfig.tailwindcss.setup({
    filetypes = {
        "html",
        "css",
        "postcss",
        "sass",
        "scss",
        "javascript",
        "javascriptreact",
        "typescriptreact",
        "svelte",
    },
    on_attach = on_attach,
    capabilities = capabilities,
})
