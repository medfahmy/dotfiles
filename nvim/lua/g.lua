require('telescope').load_extension('fzf')

require("telescope").setup({
    pickers = {
        find_files = {
            -- find_command = { "rg", "--ignore", "-L", "--hidden", "--files" },
            follow = true,
            hidden = true,
        }
    },
    defaults = {
        file_ignore_patterns = { ".git/", "Cargo.lock", }
    },
})

vim.keymap.set("n", "<space>f", require("telescope.builtin").find_files, { desc = "find files" })
vim.keymap.set("n", "<space>o", require("telescope.builtin").oldfiles, { desc = "find recently opened files" })
vim.keymap.set("n", "<space>b", require("telescope.builtin").buffers, { desc = "find existing buffers" })
vim.keymap.set("n", "<space>/", function()
    -- you can pass additional configuration to telescope to change theme, layout, etc.
    require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
        winblend = 10,
        previewer = false,
    })
end, { desc = "fuzzily search in current buffer" })

vim.keymap.set("n", "<space>h", require("telescope.builtin").help_tags, { desc = "find help" })
vim.keymap.set("n", "<space>w", require("telescope.builtin").grep_string, { desc = "find word by file" })
vim.keymap.set("n", "<space>g", require("telescope.builtin").live_grep, { desc = "find by grep" })


-- require("nvim-treesitter").setup {
--     -- Add languages to be installed here that you want installed for treesitter
--     ensure_installed = { "rust", "lua", "markdown_inline" },
--
--     -- ensure_installed
--
--     -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
--     auto_install = true,
--
--     highlight = { enable = false },
--     indent = { enable = true },
--     -- incremental_selection = {
--     --     enable = true,
--     --     keymaps = {
--     --         init_selection = "<c-space>",
--     --         node_incremental = "<c-space>",
--     --         scope_incremental = "<c-s>",
--     --         node_decremental = "<M-space>",
--     --     },
--     -- },
-- }

local on_attach = function(_, bufnr)
    local nmap = function(keys, func, desc)
        if desc then
            desc = "LSP: " .. desc
        end

        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
    end

    nmap("<space>r", vim.lsp.buf.rename, "rename")
    -- nmap("<space>la", vim.lsp.buf.code_action, "[C]ode [A]ction")
    nmap("<space>[", vim.diagnostic.goto_prev, "prev error")
    nmap("<space>]", vim.diagnostic.goto_next, "next error")
    nmap("<space>e", vim.diagnostic.open_float, "show error")
    nmap("<space>q", vim.diagnostic.setloclist, "error list")

    nmap("<space>d", vim.lsp.buf.definition, "goto definition")
    -- nmap("<space>lr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
    -- nmap("<space>li", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
    -- nmap("<space>ld", vim.lsp.buf.type_definition, "Type [D]efinition")
    -- nmap("<space>ls", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
    -- nmap("<space>lw", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

    nmap("<space>h", vim.lsp.buf.hover, "hover")
    -- nmap("<space>k", vim.lsp.buf.signature_help, "Signature Documentation")

    -- nmap("<space>d", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    -- nmap("<space>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
    -- nmap("<space>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
    -- nmap("<space>wl", function()
    --     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, "[W]orkspace [L]ist Folders")

    nmap("<space>c", function(_)
        vim.lsp.buf.format()
    end, "format")
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

