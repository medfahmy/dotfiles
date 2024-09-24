require("nvim-treesitter").setup {
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = { "lua", "python", "rust", "markdown_inline" },

    -- ensure_installed

    -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
    auto_install = true,

    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<c-space>",
            node_incremental = "<c-space>",
            scope_incremental = "<c-s>",
            node_decremental = "<M-space>",
        },
    },
}

local on_attach = function(_, bufnr)
    local nmap = function(keys, func, desc)
        if desc then
            desc = "LSP: " .. desc
        end

        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
    end

    nmap("<space>r", vim.lsp.buf.rename, "[R]e[n]ame")
    -- nmap("<space>la", vim.lsp.buf.code_action, "[C]ode [A]ction")
    nmap("<space>[", vim.diagnostic.goto_prev)
    nmap("<space>]", vim.diagnostic.goto_next)
    nmap("<space>e", vim.diagnostic.open_float)
    nmap("<space>q", vim.diagnostic.setloclist)

    nmap("<space>d", vim.lsp.buf.definition, "[G]oto [D]efinition")
    -- nmap("<space>lr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
    -- nmap("<space>li", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
    -- nmap("<space>ld", vim.lsp.buf.type_definition, "Type [D]efinition")
    -- nmap("<space>ls", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
    -- nmap("<space>lw", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

    nmap("<space>h", vim.lsp.buf.hover, "Hover Documentation")
    -- nmap("<space>k", vim.lsp.buf.signature_help, "Signature Documentation")

    -- nmap("<space>d", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    -- nmap("<space>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
    -- nmap("<space>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
    -- nmap("<space>wl", function()
    --     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, "[W]orkspace [L]ist Folders")

    nmap("<space>gf", function(_)
        vim.lsp.buf.format()
    end, "Format current buffer with LSP")
end



require("neodev").setup()

local lsp = require("lspconfig")

local capabilities = vim.lsp.protocol.make_client_capabilities()

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
                border = "single",
            },
        }
    ),
    ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "single",
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

local servers = { "rust_analyzer", "sqlls", "denols" }

lsp.denols.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    handlers = handlers,
    root_dir = lsp.util.root_pattern("deno.json", "deno.jsonc"),
}

for _, server in ipairs(servers) do
    lsp[server].setup(config)
end


local cmp = require "cmp"

cmp.setup {
    mapping = cmp.mapping.preset.insert {
        -- ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        -- ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete {},
        ["<CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
        },
        -- ["<Tab>"] = cmp.mapping(function(fallback)
        --     if cmp.visible() then
        --         cmp.select_next_item()
        --     else
        --         fallback()
        --     end
        -- end, { "i", "s" }),
        -- ["<S-Tab>"] = cmp.mapping(function(fallback)
        --     if cmp.visible() then
        --         cmp.select_prev_item()
        --     else
        --         fallback()
        --     end
        -- end, { "i", "s" }),
    },
    sources = {
        { name = "nvim_lsp" },
        { name = 'luasnip' },
    },
    snippet = {
        expand = function(args)
            require'luasnip'.lsp_expand(args.body)
        end
    },

    --             sources = {
    --                 { name = 'luasnip' },
    --                 -- more sources
    --             },
}

