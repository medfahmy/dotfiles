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
vim.keymap.set("n", "<space>to", require("telescope.builtin").oldfiles, { desc = "find recently opened files" })
vim.keymap.set("n", "<space>tb", require("telescope.builtin").buffers, { desc = "find existing buffers" })
vim.keymap.set("n", "<space>tr", function()
    -- you can pass additional configuration to telescope to change theme, layout, etc.
    require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
        winblend = 10,
        previewer = false,
    })
end, { desc = "fuzzily search in current buffer" })

vim.keymap.set("n", "<space>th", require("telescope.builtin").help_tags, { desc = "find help" })
-- vim.keymap.set("n", "<space>w", require("telescope.builtin").grep_string, { desc = "find word by file" })
vim.keymap.set("n", "<space>tg", require("telescope.builtin").live_grep, { desc = "find by grep" })

require("nvim-treesitter").setup {
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = { "rust", "wgsl", "lua", "markdown", "markdown_inline", "elm", "http",  "javascript" },

    -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
    auto_install = true,

    highlight = { enable = true },
    indent = { enable = true },
    -- incremental_selection = {
    --     enable = true,
    --     keymaps = {
    --         init_selection = "<c-space>",
    --         node_incremental = "<c-space>",
    --         scope_incremental = "<c-s>",
    --         node_decremental = "<M-space>",
    --     },
    -- },
}

local on_attach = function(client, bufnr)
    client.server_capabilities.semanticTokensProvider = nil

    local map = function(keys, func, desc)
        if desc then
            desc = "LSP: " .. desc
        end

        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
    end

    map("<space>d", vim.lsp.buf.definition, "goto definition")
    map("<space>r", vim.lsp.buf.rename, "rename")

    map("<space>h", function() vim.lsp.buf.hover({
        border = "single",
    }) end, "hover")

    map("<space>e", function() vim.diagnostic.open_float({
        border = "single",
        virtual_lines = true,
        virtual_text = true,
        underline = false,
    }) end, "show error")
    map("<space>[", vim.diagnostic.goto_prev, "prev error")
    map("<space>]", vim.diagnostic.goto_next, "next error")

    map("<space>lq", vim.diagnostic.setloclist, "error list")
    map("<space>la", vim.lsp.buf.code_action, "[C]ode [A]ction")
    map("<space>lr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

    -- map("<space>li", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
    -- map("<space>ld", vim.lsp.buf.type_definition, "Type [D]efinition")
    -- map("<space>ls", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
    -- map("<space>lw", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

    -- map("<space>k", vim.lsp.buf.signature_help, "Signature Documentation")

    -- map("<space>d", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    -- map("<space>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
    -- map("<space>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
    -- map("<space>wl", function()
    --     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, "[W]orkspace [L]ist Folders")

    map("<space>lf", function(_)
        vim.lsp.buf.format()
    end, "Format buffer")
end


require("neodev").setup()

-- local handlers = {
--     ["textDocument/publishDiagnostics"] = vim.lsp.with(
--         vim.lsp.diagnostic.on_publish_diagnostics,
--         {
--             virtual_lines = false,
--             virtual_text = false,
--             underline = true,
--         }
--     ),
--     ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
--         border = "single",
--     }),
--     ["textDocument/signatureHelp"] = vim.lsp.with(
--         vim.lsp.handlers.signature_help,
--         {
--             border = "single",
--         }
--     ),
-- }
--

local config = {
    capabilities = capabilities,
}

local capabilities = require('blink.cmp').get_lsp_capabilities()
local lspconfig = require('lspconfig')

lspconfig['rust_analyzer'].setup({ 
    on_attach = on_attach,
    capabilities = capabilities 
    -- handlers = handlers,
})

vim.diagnostic.config({
  -- virtual_text = {
  --   source = "if_many",
  --   prefix = '● ',
  -- },
  virtual_text = false,
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = 'minimal',
    border = 'rounded',
    source = 'if_many',
    header = '',
    prefix = '',
  },
})
