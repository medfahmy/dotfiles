local lspconfig = require("lspconfig")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local on_attach = function(client, bufnr)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    function nnoremap(remap, orig)
        vim.keymap.set("n", remap, orig, bufopts)
    end

    nnoremap("<space>lc", vim.lsp.buf.declaration)
    nnoremap("<space>ld", vim.lsp.buf.definition)
    nnoremap("<space>lh", vim.lsp.buf.hover)
    nnoremap("<space>ll", vim.diagnostic.open_float)
    nnoremap("<space>lr", vim.lsp.buf.rename)
    nnoremap("<space>la", vim.lsp.buf.code_action)
    nnoremap("<space>le", vim.lsp.buf.references)
    nnoremap("<space>lf", vim.lsp.buf.formatting)

    nnoremap("<space>tr", "<cmd>TroubleToggle<cr>")
end

local config = {
    on_attach = on_attach,
    capabilities = capabilities,
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
