-- vim.o.hlsearch = false
-- vim.wo.number = true
-- vim.o.mouse = "a"
-- vim.o.breakindent = true
-- vim.o.undofile = true
-- vim.o.ignorecase = true
-- vim.o.smartcase = true
-- vim.wo.signcolumn = "yes"
-- vim.o.updatetime = 250
-- vim.o.timeout = true
-- vim.o.timeoutlen = 300
-- vim.o.completeopt = "menuone,noselect"
-- vim.o.termguicolors = true
-- vim.o.guicursor = "a:block"
-- vim.o.cursorline = true
-- vim.o.tabstop = 4
-- vim.o.shiftwidth = 4
-- vim.o.softtabstop = 4
-- vim.o.expandtab = true
-- vim.o.laststatus = 3
-- vim.o.scrolloff = 8
-- vim.o.swapfile = false

local o = vim.o

o.guicursor = "a:block"
o.pumblend = 17
o.wildmode = "longest:full"
o.wildoptions = "pum"
o.title = true
o.autoread = true
o.conceallevel = 0
o.history = 9000
o.undolevels = 2000
o.lazyredraw = true
o.wildignorecase = true
o.wildignore =
    ".git,.hg,*.o,*.a,*.class,*.jar,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,*.pyc,*.pyo,**/cache/*,**/logs/*,**/target/*,*.hi,tags,**/dist/*,**/public/**/vendor/**,**/public/vendor/**,**/node_modules/**"
o.path = o.path .. "**"
o.showmode = false
o.showcmd = true
o.showmatch = true
o.number = true
o.relativenumber = true
o.ignorecase = true
o.smartcase = true
o.hidden = true
o.cursorline = true
-- o.colorcolumn = "80"
-- o.cursorlineopt = "number"
o.equalalways = false
o.splitright = true
o.splitbelow = false
o.autoindent = true
o.cindent = true
o.wrap = true
o.tabstop = 4
o.shiftwidth = 4
o.softtabstop = 4
o.expandtab = true
o.breakindent = true
o.showbreak = string.rep(" ", 3)
o.linebreak = true
o.foldmethod = "marker"
o.foldlevel = 0
o.modelines = 1
o.belloff = "all"
-- o.clipboard = "unnamedplus"
o.inccommand = "split"
o.mouse = o.mouse .. "a"
o.laststatus = 3
o.shortmess = "aW"
-- o.winbar = "%=%m\\ %f"
o.errorbells = false
o.smartindent = true
o.swapfile = false
o.backup = false
o.undodir = os.getenv("HOME") .. "/.vim/undodir"
o.undofile = true
o.hlsearch = false
o.incsearch = true
o.termguicolors = true
o.scrolloff = 8
o.signcolumn = "yes"
-- o.cmdheight = 2
o.updatetime = 50
o.list = true
-- o.listchars = "eol:↴"
o.fillchars = "eob: "
o.formatoptions = ""
-- o.statusline = " "

vim.cmd([[
    set guioptions-=e
    set guioptions+=!
    set sessionoptions+=tabpages,globals
    set shellcmdflag-=ic
    syntax enable
]])

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        'projekt0n/github-nvim-theme',
        lazy = false,  -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            require('github-theme').setup({
                -- ...
            })

            vim.cmd('colorscheme github_dark_high_contrast')
        end,
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "j-hui/fidget.nvim", opts = {} },
            "folke/neodev.nvim",
        },
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
        },
    },
    {
        "folke/which-key.nvim",
        opts = {}
    },
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            signs = {
                add = { text = "+" },
                change = { text = "~" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
            },
        },
    },
    {
        "nvim-lualine/lualine.nvim",
        opts = {
            options = {
                icons_enabled = false,
                -- theme = "iceberg_dark",
                section_separators = { "█▎", "█▎" },
                component_separators = { "▎", "▎" },
                disabled_filetypes = {},
                always_divide_middle = true,
            },
            sections = {
                lualine_a = { "mode" },
                lualine_c = { "diff" },
                lualine_x = {
                    { "diagnostics", sources = { "nvim_diagnostic" } },
                },
                lualine_y = {
                    {
                        function()
                            local msg = ""
                            local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
                            local clients = vim.lsp.get_active_clients()
                            if next(clients) == nil then
                                return msg
                            end
                            for _, client in ipairs(clients) do
                                local filetypes = client.config.filetypes
                                if
                                    filetypes
                                    and vim.fn.index(filetypes, buf_ft) ~= -1
                                then
                                    msg = msg .. " " .. client.name
                                end
                            end
                            return msg
                        end,
                    },
                },
                lualine_z = { "branch" },
                lualine_b = { { "filename", path = 1 } },
            },
        },
    },
    {
        "rmagatti/auto-session",
        opts = { log_level = "error" }
    },
    { "numToStr/Comment.nvim", opts = {} },
    {
        "nvim-telescope/telescope.nvim",
        version = "*",
        dependencies = { "nvim-lua/plenary.nvim" }
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
            return vim.fn.executable "make" == 1
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            pcall(require("nvim-treesitter.install").update { with_sync = true })
        end,
    },
}, {})



local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = "*",
})

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require("telescope").setup {
    defaults = {
        mappings = {
            i = {
                ["<C-u>"] = false,
                ["<C-d>"] = false,
            },
        },
    },
}

-- Enable telescope fzf native, if installed
pcall(require("telescope").load_extension, "fzf")

-- See `:help telescope.builtin`
vim.keymap.set("n", "<space>?", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
vim.keymap.set("n", "<space><space>", require("telescope.builtin").buffers, { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<space>/", function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
        winblend = 10,
        previewer = false,
    })
end, { desc = "[/] Fuzzily search in current buffer" })

vim.keymap.set("n", "<space>f", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<space>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<space>sw", require("telescope.builtin").grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<space>sg", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<space>sd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require("nvim-treesitter.configs").setup {
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = { "c", "cpp", "go", "lua", "python", "rust", "tsx", "typescript", "vim", "markdown" },

    -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
    auto_install = false,

    highlight = { enable = true },
    indent = { enable = true, disable = { "python" } },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<c-space>",
            node_incremental = "<c-space>",
            scope_incremental = "<c-s>",
            node_decremental = "<M-space>",
        },
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["aa"] = "@parameter.outer",
                ["ia"] = "@parameter.inner",
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
            },
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                ["]m"] = "@function.outer",
                ["]]"] = "@class.outer",
            },
            goto_next_end = {
                ["]M"] = "@function.outer",
                ["]["] = "@class.outer",
            },
            goto_previous_start = {
                ["[m"] = "@function.outer",
                ["[["] = "@class.outer",
            },
            goto_previous_end = {
                ["[M"] = "@function.outer",
                ["[]"] = "@class.outer",
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ["<space>a"] = "@parameter.inner",
            },
            swap_previous = {
                ["<space>A"] = "@parameter.inner",
            },
        },
    },
}

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
    -- NOTE: Remember that lua is a real programming language, and as such it is possible
    -- to define small helper and utility functions so you don"t have to repeat yourself
    -- many times.
    --
    -- In this case, we create a function that lets us more easily define mappings specific
    -- for LSP related items. It sets the mode, buffer and description for us each time.
    local nmap = function(keys, func, desc)
        if desc then
            desc = "LSP: " .. desc
        end

        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
    end

    nmap("<space>r", vim.lsp.buf.rename, "[R]e[n]ame")
    nmap("<space>a", vim.lsp.buf.code_action, "[C]ode [A]ction")

    nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
    nmap("<space>lr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
    nmap("<space>i", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
    nmap("<space>D", vim.lsp.buf.type_definition, "Type [D]efinition")
    nmap("<space>ls", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
    nmap("<space>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

    -- See `:help K` for why this keymap
    nmap("<space>h", vim.lsp.buf.hover, "Hover Documentation")
    nmap("<space>k", vim.lsp.buf.signature_help, "Signature Documentation")

    -- Lesser used LSP functionality
    nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    nmap("<space>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
    nmap("<space>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
    nmap("<space>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, "[W]orkspace [L]ist Folders")

    -- Create a command `:Format` local to the LSP buffer
    nmap("<space>gf", function(_)
        vim.lsp.buf.format()
    end, "Format current buffer with LSP")
end

-- }
--
-- lua_ls = {
--     Lua = {
--         workspace = { checkThirdParty = false },
--         telemetry = { enable = false },
--     },
-- }


-- Setup neovim lua configuration
require("neodev").setup()

local lspconfig = require("lspconfig")

local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true

-- local on_attacher = function(disable_diagnostic)
--     return function(client, _)
--         local nnoremap = require("keymap").nnoremap
--
--         nnoremap("<space>lw", vim.diagnostic.enable)
--
--         nnoremap("<space>d", vim.lsp.buf.definition)
--         nnoremap("<space>h", vim.lsp.buf.hover)
--         -- nnoremap("<space>lh", vim.lsp.buf.signature_help)
--         nnoremap("<space>e", function()
--             vim.diagnostic.open_float({ border = "single" })
--         end)
--         nnoremap("<space>r", vim.lsp.buf.rename)
--         nnoremap("<space>a", vim.lsp.buf.code_action)
--         nnoremap("<space>ld", vim.lsp.buf.declaration)
--         nnoremap("<space>lr", vim.lsp.buf.references)
--         nnoremap("<space>lf", vim.lsp.buf.formatting)
--         nnoremap("<space>j", vim.diagnostic.goto_next)
--         nnoremap("<space>k", vim.diagnostic.goto_prev)
--
--         nnoremap("T", "<cmd>TroubleToggle<cr>")
--
--         if disable_diagnostic then
--             vim.diagnostic.disable()
--         end
--     end
-- end

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

local servers = { "rust_analyzer" }

for _, server in ipairs(servers) do
    lspconfig[server].setup(config)
end

-- lspconfig.rust_analyzer.setup({
--     on_attach = on_attacher(false),
--     capabilities = capabilities,
--     handlers = handlers,
--     -- cmd = {
--     --     "rustup",
--     --     "run",
--     --     "stable",
--     --     "rust-analyzer",
--     -- }
-- })

-- lspconfig.cssls.setup({
--     on_attach = on_attacher(true),
--     capabilities = capabilities,
--     handlers = handlers,
-- })

-- lspconfig.tailwindcss.setup({
--     filetypes = {
--         "html",
--         "css",
--         "postcss",
--         "sass",
--         "scss",
--         "javascript",
--         "javascriptreact",
--         "typescriptreact",
--         "svelte",
--     },
--     on_attach = on_attacher(false),
--     capabilities = capabilities,
--     handlers = handlers,
-- })

-- nvim-cmp setup
local cmp = require "cmp"
-- local luasnip = require "luasnip"

-- luasnip.config.setup {}

cmp.setup {
    -- snippet = {
    --     expand = function(args)
    --         luasnip.lsp_expand(args.body)
    --     end,
    -- },
    mapping = cmp.mapping.preset.insert {
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete {},
        ["<CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            -- elseif luasnip.expand_or_jumpable() then
                -- luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            -- elseif luasnip.jumpable(-1) then
                -- luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    },
    sources = {
        { name = "nvim_lsp" },
        -- { name = "luasnip" },
    },
}

function bind(op, outer_opts)
end

local set = vim.keymap.set

function map(op, lhs, rhs, opts)
    opts = vim.tbl_extend("force", { noremap = true, silent = true }, opts or {})
    vim.keymap.set(op, lhs, rhs, opts)
end

map({ "n", "v" }, "<space>", "<nop>")
map({ "n", "v" }, "q:", "<nop>")
map({ "n", "v" }, "Q", "<nop>")

map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
map( "n", "<space>y", '"+y')
map( "n", "<space>p", '"+p')

map("n", "<c-w>", "<c-w>w")

-- jumplist mutations
map("n", "k", '(v:count > 5 ? "m\'" . v:count : "") . \'k\'', { expr = true })
map("n", "j", '(v:count > 5 ? "m\'" . v:count : "") . \'j\'', { expr = true })
map( "n", "{", ":keepjumps normal! {<cr>")
map( "n", "}", ":keepjumps normal! }<cr>")

-- -- indenting selection while staying in visual mode
map("v", "<", "<gv")
map("v", ">", ">gv")

-- -- keeping it centered
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "J", "mzJ`z")
map("n", "<c-d>", "<c-d>zz")
map("n", "<c-u>", "<c-u>zz")
map("n", "{", "{zz")
map("n", "}", "}zz")

-- -- undo break points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", "!", "!<c-g>u")
map("i", "?", "?<c-g>u")
map("i", "(", "(<c-g>u")
map("i", ")", ")<c-g>u")
map("i", "{", "{<c-g>u")
map("i", "}", "}<c-g>u")
map("i", "[", "[<c-g>u")
map("i", "]", "]<c-g>u")
map("i", "<", "<<c-g>u")
map("i", ">", "><c-g>u")

