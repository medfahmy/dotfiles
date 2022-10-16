local lspconfig = require("lspconfig")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local on_attach = function(client, bufnr)
    local nnoremap = require("keymap").nnoremap

    nnoremap("<space>lw", vim.diagnostic.enable)

    nnoremap("<space>d", vim.lsp.buf.definition)
    nnoremap("<space>h", vim.lsp.buf.hover)
    nnoremap("<space>lh", vim.lsp.buf.signature_help)
    nnoremap("<space>e", function()
        vim.diagnostic.open_float({ border = "single" })
    end)
    nnoremap("<space>lc", vim.lsp.buf.declaration)
    nnoremap("<space>lr", vim.lsp.buf.rename)
    nnoremap("<space>la", vim.lsp.buf.code_action)
    nnoremap("<space>le", vim.lsp.buf.references)
    nnoremap("<space>lf", vim.lsp.buf.formatting)

    nnoremap("<space>v", "<cmd>TroubleToggle<cr>")
end

local border = { " ", " ", " ", " ", " ", " ", " ", " " }

local handlers = {
    ["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics,
        {
            virtual_text = false,
            underline = false,
            float = {
                pad_top = 1,
                pad_bottom = 1,
            },
        }
    ),
    ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = border,
    }),
    ["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help,
        {
            border = border,
        }
    ),
}

local config = {
    on_attach = on_attach,
    capabilities = capabilities,
    handlers = handlers,
}

local lsps = { "tsserver", "cssls", "rust_analyzer", "svelte", "pyright" }

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
    handlers = handlers,
})
