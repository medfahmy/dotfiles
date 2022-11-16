local lspconfig = require("lspconfig")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local on_attacher = function(disable_diagnostic)
    return function(client, bufnr)
        local nnoremap = require("keymap").nnoremap

        nnoremap("<space>lw", vim.diagnostic.enable)

        nnoremap("<space>d", vim.lsp.buf.definition)
        nnoremap("H", vim.lsp.buf.hover)
        nnoremap("T", vim.lsp.buf.signature_help)
        nnoremap("<space>e", function()
            vim.diagnostic.open_float({ border = "single" })
        end)
        nnoremap("<space>ld", vim.lsp.buf.declaration)
        nnoremap("R", vim.lsp.buf.rename)
        nnoremap("<space>a", vim.lsp.buf.code_action)
        nnoremap("<space>lr", vim.lsp.buf.references)
        nnoremap("<space>lf", vim.lsp.buf.formatting)

        nnoremap("T", "<cmd>TroubleToggle<cr>")

        if disable_diagnostic then
            vim.diagnostic.disable()
        end
    end
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
    on_attach = on_attacher(false),
    capabilities = capabilities,
    handlers = handlers,
}

local servers = { "tsserver", "rust_analyzer", "svelte", "pyright" }

for _, server in ipairs(servers) do
    lspconfig[server].setup(config)
end

lspconfig.cssls.setup({
    on_attach = on_attacher(true),
    capabilities = capabilities,
    handlers = handlers,
})

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
    on_attach = on_attacher(false),
    capabilities = capabilities,
    handlers = handlers,
})
