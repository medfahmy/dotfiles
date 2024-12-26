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
-- vim.keymap.set("n", "<space>w", require("telescope.builtin").grep_string, { desc = "find word by file" })
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
--     highlight = { enable = true },
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

local on_attach = function(client, bufnr)
    client.server_capabilities.semanticTokensProvider = nil

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

    nmap("<space>gf", function(_)
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

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup { -- BEGIN_DEFAULT_OPTS
    on_attach = "default",
    hijack_cursor = false,
    auto_reload_on_write = true,
    disable_netrw = false,
    hijack_netrw = true,
    hijack_unnamed_buffer_when_opening = false,
    root_dirs = {},
    prefer_startup_root = false,
    sync_root_with_cwd = false,
    reload_on_bufenter = false,
    respect_buf_cwd = false,
    select_prompts = false,
    sort = {
        sorter = "name",
        folders_first = true,
        files_first = false,
    },
    view = {
        centralize_selection = false,
        cursorline = true,
        debounce_delay = 15,
        side = "right",
        preserve_window_proportions = false,
        number = false,
        relativenumber = false,
        signcolumn = "yes",
        width = 30,
        float = {
            enable = false,
            quit_on_focus_loss = true,
            open_win_config = {
                relative = "editor",
                border = "rounded",
                width = 30,
                height = 30,
                row = 1,
                col = 1,
            },
        },
    },
    renderer = {
        add_trailing = false,
        group_empty = false,
        full_name = false,
        root_folder_label = ":~:s?$?/..?",
        indent_width = 2,
        special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
        hidden_display = "none",
        symlink_destination = true,
        decorators = { "Git", "Open", "Hidden", "Modified", "Bookmark", "Diagnostics", "Copied", "Cut", },
        highlight_git = "none",
        highlight_diagnostics = "none",
        highlight_opened_files = "none",
        highlight_modified = "none",
        highlight_hidden = "none",
        highlight_bookmarks = "none",
        highlight_clipboard = "name",
        indent_markers = {
            enable = false,
            inline_arrows = true,
            icons = {
                corner = "└",
                edge = "│",
                item = "│",
                bottom = "─",
                none = " ",
            },
        },
        icons = {
            web_devicons = {
                file = {
                    enable = false,
                    color = true,
                },
                folder = {
                    enable = false,
                    color = true,
                },
            },
            git_placement = "before",
            modified_placement = "after",
            hidden_placement = "after",
            diagnostics_placement = "signcolumn",
            bookmarks_placement = "signcolumn",
            padding = " ",
            symlink_arrow = " ➛ ",
            show = {
                file = false,
                folder = false,
                folder_arrow = false,
                git = false,
                modified = false,
                hidden = false,
                diagnostics = false,
                bookmarks = false,
            },
            glyphs = {
                default = "",
                symlink = "",
                bookmark = "󰆤",
                modified = "●",
                hidden = "󰜌",
                folder = {
                    arrow_closed = "",
                    arrow_open = "",
                    default = "",
                    open = "",
                    empty = "",
                    empty_open = "",
                    symlink = "",
                    symlink_open = "",
                },
                git = {
                    unstaged = "✗",
                    staged = "✓",
                    unmerged = "",
                    renamed = "➜",
                    untracked = "★",
                    deleted = "",
                    ignored = "◌",
                },
            },
        },
    },
    hijack_directories = {
        enable = true,
        auto_open = true,
    },
    update_focused_file = {
        enable = false,
        update_root = {
            enable = false,
            ignore_list = {},
        },
        exclude = false,
    },
    system_open = {
        cmd = "",
        args = {},
    },
    git = {
        enable = true,
        show_on_dirs = true,
        show_on_open_dirs = true,
        disable_for_dirs = {},
        timeout = 400,
        cygwin_support = false,
    },
    diagnostics = {
        enable = false,
        show_on_dirs = false,
        show_on_open_dirs = true,
        debounce_delay = 500,
        severity = {
            min = vim.diagnostic.severity.HINT,
            max = vim.diagnostic.severity.ERROR,
        },
        icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
        },
    },
    modified = {
        enable = false,
        show_on_dirs = true,
        show_on_open_dirs = true,
    },
    filters = {
        enable = true,
        git_ignored = true,
        dotfiles = false,
        git_clean = false,
        no_buffer = false,
        no_bookmark = false,
        custom = {},
        exclude = {},
    },
    live_filter = {
        prefix = "[FILTER]: ",
        always_show_folders = true,
    },
    filesystem_watchers = {
        enable = true,
        debounce_delay = 50,
        ignore_dirs = {
            "/.ccls-cache",
            "/build",
            "/node_modules",
            "/target",
        },
    },
    actions = {
        use_system_clipboard = true,
        change_dir = {
            enable = true,
            global = false,
            restrict_above_cwd = false,
        },
        expand_all = {
            max_folder_discovery = 300,
            exclude = {},
        },
        file_popup = {
            open_win_config = {
                col = 1,
                row = 1,
                relative = "cursor",
                border = "shadow",
                style = "minimal",
            },
        },
        open_file = {
            quit_on_open = false,
            eject = true,
            resize_window = true,
            relative_path = true,
            window_picker = {
                enable = true,
                picker = "default",
                chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
                exclude = {
                    filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
                    buftype = { "nofile", "terminal", "help" },
                },
            },
        },
        remove_file = {
            close_window = true,
        },
    },
    trash = {
        cmd = "gio trash",
    },
    tab = {
        sync = {
            open = false,
            close = false,
            ignore = {},
        },
    },
    notify = {
        threshold = vim.log.levels.INFO,
        absolute_path = true,
    },
    help = {
        sort_by = "key",
    },
    ui = {
        confirm = {
            remove = true,
            trash = true,
            default_yes = false,
        },
    },
    experimental = {
    },
    log = {
        enable = false,
        truncate = false,
        types = {
            all = false,
            config = false,
            copy_paste = false,
            dev = false,
            diagnostics = false,
            git = false,
            profile = false,
            watcher = false,
        },
    },
}

vim.keymap.set("n", "<space>n", "<cmd>NvimTreeToggle<cr>", { silent = true, noremap = true })
