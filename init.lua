-- lazy
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
    -- { 'RRethy/nvim-base16', opts = {} },
    -- { "norcalli/nvim-colorizer.lua", opts = {}, },
    -- { "rmehri01/onenord.nvim" },
    {
        'kaiuri/nvim-juliana',
        lazy = false,
        opts = { 
            colors = {
                bg1 = '#3b454e',
                bg2 = '#303841',
                bg3 = '#2e353e',
                fg1 = '#ffffff',
                fg2 = '#d8dee9',
                fg3 = '#a6acb8',
                fg4 = '#46525c',
                shade1 = '#2f373f',
                shade2 = '#2e363e',
                blue1 = '#95b2d6',
                blue2 = '#5c99d6',
                cyan = '#5fb4b4',
                green = '#99c794',
                magenta = '#cc8ec6',
                orange = '#f97b58',
                red = '#ec5f66',
                yellow1 = '#fac761',
                yellow2 = '#f9ae58',
                yellow3 = '#ee932b',
            }
        },
    },
    { "AlexvZyl/nordic.nvim" },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            { "j-hui/fidget.nvim", opts = {} },
            "folke/neodev.nvim",
        },
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip"
        },
    },
    { "folke/which-key.nvim", opts = {} },
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
                lualine_b = {{ "filename", path = 1 }},
            },
        },
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        opts = {
            show_current_context = true,
            show_current_context_start = false,
            show_current_context_start_on_current_line = false,
            show_end_of_line = true,
        },
    },
    { "rmagatti/auto-session", opts = { log_level = "error" } },
    { "numToStr/Comment.nvim", opts = {} },
    {
        "nvim-telescope/telescope.nvim",
        version = "*",
        dependencies = { "nvim-lua/plenary.nvim" }
    },
    {
        "ThePrimeagen/harpoon",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            vim.keymap.set("n", "<space>l", function() require("harpoon.ui").toggle_quick_menu() end, { silent = true, desc = "[l]ist harpoon marks" })
            vim.keymap.set("n", "<space>m", function() require("harpoon.mark").add_file() end, { silent = true, desc = "add harpoon [m]ark" })
            vim.keymap.set("n", "<tab>", function() require("harpoon.ui").nav_next() end, { silent = true, desc = "add harpoon [m]ark" })
            vim.keymap.set("n", "<s-tab>", function() require("harpoon.ui").nav_prev() end, { silent = true, desc = "add harpoon [m]ark" })
        end,
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

-- options
local o = vim.o

o.showmode = false
o.swapfile = false
o.backup = false
o.undodir = os.getenv("HOME") .. "/.vim/undodir"
o.undofile = true
o.hlsearch = false
o.number = true
o.mouse = "a"
o.breakindent = true
o.undofile = true
o.ignorecase = true
o.smartcase = true
o.signcolumn = "auto"
o.updatetime = 250
o.timeout = true
o.timeoutlen = 300
o.completeopt = "menuone,noselect"
o.termguicolors = true
o.guicursor = "a:block"
o.cursorline = true
o.tabstop = 4
o.shiftwidth = 4
o.softtabstop = 4
o.expandtab = true
o.laststatus = 3
o.scrolloff = 8
o.list = true
o.listchars = "eol:↴"
o.fillchars = "eob: "
o.formatoptions = ""

-- keymaps
vim.keymap.set({ "n", "v" }, "<space>", "<nop>", { silent = true })
vim.keymap.set({ "n", "v" }, "q:", "<nop>", { silent = true })
vim.keymap.set({ "n", "v" }, "Q", "<nop>", { silent = true })

vim.keymap.set("n", "<c-w>", "<c-w><c-w>")
vim.keymap.set({ "n", "v" }, "<space>x", "<cmd>bd<cr>", { silent = true })
-- vim.cmd([[tnoremap <c-[><c-[> <c-\><c-n>]])
vim.keymap.set("t", "<c-[><c-[>", "<c-\\><c-n>")

vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ "n", "v" }, "<space>y", '"+y', { silent = true })
vim.keymap.set({ "n", "v" }, "<space>Y", '"+y$', { silent = true })
vim.keymap.set({ "n", "v" }, "<space>p", '"+p', { silent = true })
vim.keymap.set({ "n", "v" }, "<space>P", '"+P', { silent = true })

-- moving text
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })

-- indenting selection while staying in visual mode
vim.keymap.set("v", "<", "<gv", { silent = true })
vim.keymap.set("v", ">", ">gv", { silent = true })

-- keeping it centered
vim.keymap.set("n", "n", "nzzzv", { silent = true })
vim.keymap.set("n", "N", "Nzzzv", { silent = true })
vim.keymap.set("n", "J", "mzJ`z", { silent = true })
vim.keymap.set("n", "<c-d>", "<c-d>zz", { silent = true })
vim.keymap.set("n", "<c-u>", "<c-u>zz", { silent = true })

-- undo break points
vim.keymap.set("i", ",", ",<c-g>u", { silent = true })
vim.keymap.set("i", ".", ".<c-g>u", { silent = true })
vim.keymap.set("i", "!", "!<c-g>u", { silent = true })
vim.keymap.set("i", "?", "?<c-g>u", { silent = true })
vim.keymap.set("i", "(", "(<c-g>u", { silent = true })
vim.keymap.set("i", ")", ")<c-g>u", { silent = true })
vim.keymap.set("i", "{", "{<c-g>u", { silent = true })
vim.keymap.set("i", "}", "}<c-g>u", { silent = true })
vim.keymap.set("i", "[", "[<c-g>u", { silent = true })
vim.keymap.set("i", "]", "]<c-g>u", { silent = true })
vim.keymap.set("i", "<", "<<c-g>u", { silent = true })
vim.keymap.set("i", ">", "><c-g>u", { silent = true })

-- jumplist mutations
vim.keymap.set("n", "k", '(v:count > 5 ? "m\'" . v:count : "") . \'k\'', { expr = true }, { silent = true })
vim.keymap.set("n", "j", '(v:count > 5 ? "m\'" . v:count : "") . \'j\'', { expr = true }, { silent = true })

-- wrapping visual selection
vim.keymap.set("v", '<space>"', '<esc>`>a"<esc>`<i"<esc>', { silent = true })
vim.keymap.set("v", "<space>(", "<esc>`>a)<esc>`<i(<esc>", { silent = true })
vim.keymap.set("v", "<space>[", "<esc>`>a]<esc>`<i[<esc>", { silent = true })
vim.keymap.set("v", "<space>'", "<esc>`>a'<esc>`<i'<esc>", { silent = true })
vim.keymap.set("v", "<space>{", "<esc>`>a}<esc>`<i{<esc>", { silent = true })

-- dont mutate jump list
vim.keymap.set("n", "{", ":keepjumps normal! {<cr>", { silent = true })
vim.keymap.set("n", "}", ":keepjumps normal! }<cr>", { silent = true })


local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = "*",
})

require("telescope").setup({
    defaults = {
        mappings = {
            i = {
                ["<C-u>"] = false,
                ["<C-d>"] = false,
                ["<esc>"] = require("telescope.actions").close,
            },
        },
    },
})

pcall(require("telescope").load_extension, "fzf")

local telescope = require("telescope.builtin")

vim.keymap.set("n", "<space>f", telescope.find_files, { desc = "telescope files" })
vim.keymap.set("n", "<space>/", telescope.oldfiles, { desc = "find recently opened files" })
vim.keymap.set("n", "<space>b", telescope.buffers, { desc = "find existing buffers" })

vim.keymap.set("n", "<space>th", telescope.help_tags, { desc = "telescope help" })
vim.keymap.set("n", "<space>tg", telescope.live_grep, { desc = "telescope grep" })
vim.keymap.set("n", "<space>td", telescope.diagnostics, { desc = "telescope diagnostics" })
vim.keymap.set("n", "<space>tk", telescope.keymaps, { desc = "telescope keymaps" })
vim.keymap.set("n", "<space>tc", telescope.colorscheme, { desc = "telescope colorschemes" })

require("nvim-treesitter.configs").setup {
    ensure_installed = { "go", "lua", "python", "rust", "tsx", "typescript", "help" },
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true },
}

-- Diagnostic keymaps
vim.keymap.set("n", "<space>k", vim.diagnostic.goto_prev)
vim.keymap.set("n", "<space>j", vim.diagnostic.goto_next)
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
-- vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

local nmap = function(keys, func, desc)
    if desc then
        desc = "lsp: " .. desc
end
    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
end

nmap("<leader>r", vim.lsp.buf.rename, "[r]ename")
nmap("<leader>ca", vim.lsp.buf.code_action, "[c]ode [a]ction")

nmap("gd", vim.lsp.buf.definition, "[g]oto [d]efinition")
nmap("gr", require("telescope.builtin").lsp_references, "[g]oto [r]eferences")
nmap("gI", vim.lsp.buf.implementation, "[g]oto [I]mplementation")
nmap("<leader>D", vim.lsp.buf.type_definition, "type [d]efinition")
nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[d]ocument [s]ymbols")
nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[w]orkspace [s]ymbols")

nmap("<space>h", vim.lsp.buf.hover, "[h]over documentation")
nmap("<space>vh", vim.lsp.buf.signature_help, "[hover] signature Documentation")

nmap("<space>d", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[w]orkspace [a]dd folder")
nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[w]orkspace [r]emove folder")
nmap("<space>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, "[w]orkspace [l]ist folders")

nmap("<space>gf", vim.lsp.buf.format, "[f]ormat buffer")

local servers = {
    pyright = {},
    rust_analyzer = {},
    tsserver = {},
    gopls = {},
}

local handlers = {
    ["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics,
        {
            virtual_text = false,
            underline = true,
        }
    ),
    ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "single",
    }),
    ["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help,
        {
            border = "single",
        }
    ),
}

vim.diagnostic.config {     
    float = { 
        border = "single",
    }, 
}

require("neodev").setup()

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

require("mason").setup()

local mason_lspconfig = require "mason-lspconfig"

mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
    function(server_name)
        require("lspconfig")[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
            handlers = handlers,
        }
    end,
}

local cmp = require "cmp"
local luasnip = require "luasnip"

luasnip.config.setup {}

cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert {
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete {},
        ["<CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
    },
}

vim.cmd("colorscheme juliana")
vim.cmd("hi CursorLine guibg=#333333")
vim.cmd("hi CursorLineNr guifg=#fac863 guibg=#333333")
vim.cmd("hi WhichKeyFloat guibg=#333333")
vim.cmd("hi Normal guibg=none")
-- vim.cmd("hi NormalFloat guibg=#333333")
vim.cmd("hi LineNr guibg=none guifg=#555555")
vim.cmd("hi SignColumn guibg=none")
