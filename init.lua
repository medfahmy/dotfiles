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
            vim.keymap.set({ "n" }, "<space>l", function() require("harpoon.ui").toggle_quick_menu() end, { silent = true })
            vim.keymap.set({ "n" }, "<space>m", function() require("harpoon.mark").add_file() end, { silent = true })
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

vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ "n", "v" }, "<space>y", '"+y', { silent = true })
vim.keymap.set({ "n", "v" }, "<space>Y", '"+y$', { silent = true })
vim.keymap.set({ "n", "v" }, "<space>p", '"+p', { silent = true })
vim.keymap.set({ "n", "v" }, "<space>P", '"+P', { silent = true })

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
                ["<esc>"] = require("telescope.actions").close,
            },
        },
    },
}

-- Enable telescope fzf native, if installed
pcall(require("telescope").load_extension, "fzf")

-- See `:help telescope.builtin`
vim.keymap.set("n", "<space><space>", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
vim.keymap.set("n", "<space>b", require("telescope.builtin").buffers, { desc = "[ ] Find existing buffers" })
-- vim.keymap.set("n", "<leader>/", function()
--     -- You can pass additional configuration to telescope to change theme, layout, etc.
--     require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
--         winblend = 10,
--         previewer = false,
-- })
-- end, { desc = "[/] Fuzzily search in current buffer" })

vim.keymap.set("n", "<space>f", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<space>th", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
-- vim.keymap.set("n", "<space>sw", require("telescope.builtin").grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<space>tg", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<space>td", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require("nvim-treesitter.configs").setup {
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = { "go", "lua", "python", "rust", "tsx", "typescript", "help" },

-- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
    auto_install = true,

    highlight = { enable = true },
    indent = { enable = true },
}

-- Diagnostic keymaps
vim.keymap.set("n", "<space>k", vim.diagnostic.goto_prev)
vim.keymap.set("n", "<space>j", vim.diagnostic.goto_next)
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
-- vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
end
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


    nmap("<leader>r", vim.lsp.buf.rename, "[R]e[n]ame")
    nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

    nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
    nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
    nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
    nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
    nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
    nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

    -- See `:help K` for why this keymap
    nmap("<space>h", vim.lsp.buf.hover, "Hover Documentation")
    nmap("<space>vh", vim.lsp.buf.signature_help, "Signature Documentation")

    -- Lesser used LSP functionality
    nmap("<space>d", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
    nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
    nmap("<space>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, "[W]orkspace [L]ist Folders")

    nmap("<space>gf", vim.lsp.buf.format, "Format current buffer with LSP")

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
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

-- Setup neovim lua configuration
require("neodev").setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Setup mason so it can manage external tooling
require("mason").setup()

-- Ensure the servers above are installed
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

-- nvim-cmp setup
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

local M = {}
local hex_re = vim.regex('#\\x\\x\\x\\x\\x\\x')

local HEX_DIGITS = {
        ['0'] = 0,
        ['1'] = 1,
        ['2'] = 2,
        ['3'] = 3,
        ['4'] = 4,
        ['5'] = 5,
        ['6'] = 6,
        ['7'] = 7,
        ['8'] = 8,
        ['9'] = 9,
        ['a'] = 10,
        ['b'] = 11,
        ['c'] = 12,
        ['d'] = 13,
        ['e'] = 14,
        ['f'] = 15,
        ['A'] = 10,
        ['B'] = 11,
        ['C'] = 12,
        ['D'] = 13,
        ['E'] = 14,
        ['F'] = 15,
}

local function hex_to_rgb(hex)
    return HEX_DIGITS[string.sub(hex, 1, 1)] * 16 + HEX_DIGITS[string.sub(hex, 2, 2)],
        HEX_DIGITS[string.sub(hex, 3, 3)] * 16 + HEX_DIGITS[string.sub(hex, 4, 4)],
        HEX_DIGITS[string.sub(hex, 5, 5)] * 16 + HEX_DIGITS[string.sub(hex, 6, 6)]
end

local function rgb_to_hex(r, g, b)
    return bit.tohex(bit.bor(bit.lshift(r, 16), bit.lshift(g, 8), b), 6)
end

local function darken(hex, pct)
    pct = 1 - pct
    local r, g, b = hex_to_rgb(string.sub(hex, 2))
    r = math.floor(r * pct)
    g = math.floor(g * pct)
    b = math.floor(b * pct)
    return string.format("#%s", rgb_to_hex(r, g, b))
end

-- This is a bit of syntactic sugar for creating highlight groups.
--
-- local colorscheme = require('colorscheme')
-- local hi = colorscheme.highlight
-- hi.Comment = { guifg='#ffffff', guibg='#000000', gui='italic', guisp=nil }
-- hi.LspDiagnosticsDefaultError = 'DiagnosticError' -- Link to another group
--
-- This is equivalent to the following vimscript
--
-- hi Comment guifg=#ffffff guibg=#000000 gui=italic
-- hi! link LspDiagnosticsDefaultError DiagnosticError
M.highlight = setmetatable({}, {
    __newindex = function(_, hlgroup, args)
        if ('string' == type(args)) then
            vim.cmd(('hi! link %s %s'):format(hlgroup, args))
            return
        end

        local guifg, guibg, gui, guisp = args.guifg or nil, args.guibg or nil, args.gui or nil, args.guisp or nil
        local cmd = { 'hi', hlgroup }
        if guifg then table.insert(cmd, 'guifg=' .. guifg) end
        if guibg then table.insert(cmd, 'guibg=' .. guibg) end
        if gui then table.insert(cmd, 'gui=' .. gui) end
        if guisp then table.insert(cmd, 'guisp=' .. guisp) end
        vim.cmd(table.concat(cmd, ' '))
    end
})

function M.setup(colors)

    if vim.fn.exists('syntax_on') then
        vim.cmd('syntax reset')
    end
    vim.cmd('set termguicolors')

    M.colors                              = colors
    local hi                              = M.highlight

    -- Vim editor colors
    hi.Normal                             = { guifg = M.colors.base05, guibg = M.colors.base00, gui = nil, guisp = nil }
    hi.Bold                               = { guifg = nil, guibg = nil, gui = 'bold', guisp = nil }
    hi.Debug                              = { guifg = M.colors.base08, guibg = nil, gui = nil, guisp = nil }
    hi.Directory                          = { guifg = M.colors.base0D, guibg = nil, gui = nil, guisp = nil }
    hi.Error                              = { guifg = M.colors.base00, guibg = M.colors.base08, gui = nil, guisp = nil }
    hi.ErrorMsg                           = { guifg = M.colors.base08, guibg = M.colors.base00, gui = nil, guisp = nil }
    hi.Exception                          = { guifg = M.colors.base08, guibg = nil, gui = nil, guisp = nil }
    hi.FoldColumn                         = { guifg = M.colors.base0C, guibg = M.colors.base00, gui = nil, guisp = nil }
    hi.Folded                             = { guifg = M.colors.base03, guibg = M.colors.base01, gui = nil, guisp = nil }
    hi.IncSearch                          = { guifg = M.colors.base01, guibg = M.colors.base09, gui = 'none', guisp = nil }
    hi.Italic                             = { guifg = nil, guibg = nil, gui = 'none', guisp = nil }
    hi.Macro                              = { guifg = M.colors.base08, guibg = nil, gui = nil, guisp = nil }
    hi.MatchParen                         = { guifg = nil, guibg = M.colors.base03, gui = nil, guisp = nil }
    hi.ModeMsg                            = { guifg = M.colors.base0B, guibg = nil, gui = nil, guisp = nil }
    hi.MoreMsg                            = { guifg = M.colors.base0B, guibg = nil, gui = nil, guisp = nil }
    hi.Question                           = { guifg = M.colors.base0D, guibg = nil, gui = nil, guisp = nil }
    hi.Search                             = { guifg = M.colors.base01, guibg = M.colors.base0A, gui = nil, guisp = nil }
    hi.Substitute                         = { guifg = M.colors.base01, guibg = M.colors.base0A, gui = 'none', guisp = nil }
    hi.SpecialKey                         = { guifg = M.colors.base03, guibg = nil, gui = nil, guisp = nil }
    hi.TooLong                            = { guifg = M.colors.base08, guibg = nil, gui = nil, guisp = nil }
    hi.Underlined                         = { guifg = M.colors.base08, guibg = nil, gui = nil, guisp = nil }
    hi.Visual                             = { guifg = nil, guibg = M.colors.base02, gui = nil, guisp = nil }
    hi.VisualNOS                          = { guifg = M.colors.base08, guibg = nil, gui = nil, guisp = nil }
    hi.WarningMsg                         = { guifg = M.colors.base08, guibg = nil, gui = nil, guisp = nil }
    hi.WildMenu                           = { guifg = M.colors.base08, guibg = M.colors.base0A, gui = nil, guisp = nil }
    hi.Title                              = { guifg = M.colors.base0D, guibg = nil, gui = 'none', guisp = nil }
    hi.Conceal                            = { guifg = M.colors.base0D, guibg = M.colors.base00, gui = nil, guisp = nil }
    hi.Cursor                             = { guifg = M.colors.base00, guibg = M.colors.base05, gui = nil, guisp = nil }
    hi.NonText                            = { guifg = M.colors.base03, guibg = nil, gui = nil, guisp = nil }
    hi.LineNr                             = { guifg = M.colors.base04, guibg = M.colors.base00, gui = nil, guisp = nil }
    hi.SignColumn                         = { guifg = M.colors.base04, guibg = M.colors.base00, gui = nil, guisp = nil }
    hi.StatusLine                         = { guifg = M.colors.base05, guibg = M.colors.base02, gui = 'none', guisp = nil }
    hi.StatusLineNC                       = { guifg = M.colors.base04, guibg = M.colors.base01, gui = 'none', guisp = nil }
    hi.WinBar                             = { guifg = M.colors.base05, guibg = nil, gui = 'none', guisp = nil }
    hi.WinBarNC                           = { guifg = M.colors.base04, guibg = nil, gui = 'none', guisp = nil }
    hi.VertSplit                          = { guifg = M.colors.base05, guibg = M.colors.base00, gui = 'none', guisp = nil }
    hi.ColorColumn                        = { guifg = nil, guibg = M.colors.base01, gui = 'none', guisp = nil }
    hi.CursorColumn                       = { guifg = nil, guibg = M.colors.base01, gui = 'none', guisp = nil }
    hi.CursorLine                         = { guifg = nil, guibg = M.colors.base01, gui = 'none', guisp = nil }
    hi.CursorLineNr                       = { guifg = M.colors.base04, guibg = M.colors.base01, gui = nil, guisp = nil }
    hi.QuickFixLine                       = { guifg = nil, guibg = M.colors.base01, gui = 'none', guisp = nil }
    hi.PMenu                              = { guifg = M.colors.base05, guibg = M.colors.base01, gui = 'none', guisp = nil }
    hi.PMenuSel                           = { guifg = M.colors.base01, guibg = M.colors.base05, gui = nil, guisp = nil }
    hi.TabLine                            = { guifg = M.colors.base03, guibg = M.colors.base01, gui = 'none', guisp = nil }
    hi.TabLineFill                        = { guifg = M.colors.base03, guibg = M.colors.base01, gui = 'none', guisp = nil }
    hi.TabLineSel                         = { guifg = M.colors.base0B, guibg = M.colors.base01, gui = 'none', guisp = nil }

    -- Standard syntax highlighting
    hi.Boolean                            = { guifg = M.colors.base09, guibg = nil, gui = nil, guisp = nil }
    hi.Character                          = { guifg = M.colors.base08, guibg = nil, gui = nil, guisp = nil }
    hi.Comment                            = { guifg = M.colors.base03, guibg = nil, gui = nil, guisp = nil }
    hi.Conditional                        = { guifg = M.colors.base0E, guibg = nil, gui = nil, guisp = nil }
    hi.Constant                           = { guifg = M.colors.base09, guibg = nil, gui = nil, guisp = nil }
    hi.Define                             = { guifg = M.colors.base0E, guibg = nil, gui = 'none', guisp = nil }
    hi.Delimiter                          = { guifg = M.colors.base0F, guibg = nil, gui = nil, guisp = nil }
    hi.Float                              = { guifg = M.colors.base09, guibg = nil, gui = nil, guisp = nil }
    hi.Function                           = { guifg = M.colors.base0D, guibg = nil, gui = nil, guisp = nil }
    hi.Identifier                         = { guifg = M.colors.base08, guibg = nil, gui = 'none', guisp = nil }
    hi.Include                            = { guifg = M.colors.base0D, guibg = nil, gui = nil, guisp = nil }
    hi.Keyword                            = { guifg = M.colors.base0E, guibg = nil, gui = nil, guisp = nil }
    hi.Label                              = { guifg = M.colors.base0A, guibg = nil, gui = nil, guisp = nil }
    hi.Number                             = { guifg = M.colors.base09, guibg = nil, gui = nil, guisp = nil }
    hi.Operator                           = { guifg = M.colors.base05, guibg = nil, gui = 'none', guisp = nil }
    hi.PreProc                            = { guifg = M.colors.base0A, guibg = nil, gui = nil, guisp = nil }
    hi.Repeat                             = { guifg = M.colors.base0A, guibg = nil, gui = nil, guisp = nil }
    hi.Special                            = { guifg = M.colors.base0C, guibg = nil, gui = nil, guisp = nil }
    hi.SpecialChar                        = { guifg = M.colors.base0F, guibg = nil, gui = nil, guisp = nil }
    hi.Statement                          = { guifg = M.colors.base08, guibg = nil, gui = nil, guisp = nil }
    hi.StorageClass                       = { guifg = M.colors.base0A, guibg = nil, gui = nil, guisp = nil }
    hi.String                             = { guifg = M.colors.base0B, guibg = nil, gui = nil, guisp = nil }
    hi.Structure                          = { guifg = M.colors.base0E, guibg = nil, gui = nil, guisp = nil }
    hi.Tag                                = { guifg = M.colors.base0A, guibg = nil, gui = nil, guisp = nil }
    hi.Todo                               = { guifg = M.colors.base0A, guibg = M.colors.base01, gui = nil, guisp = nil }
    hi.Type                               = { guifg = M.colors.base0A, guibg = nil, gui = 'none', guisp = nil }
    hi.Typedef                            = { guifg = M.colors.base0A, guibg = nil, gui = nil, guisp = nil }

    -- Diff highlighting
    hi.DiffAdd                            = { guifg = M.colors.base0B, guibg = M.colors.base00, gui = nil, guisp = nil }
    hi.DiffChange                         = { guifg = M.colors.base03, guibg = M.colors.base00, gui = nil, guisp = nil }
    hi.DiffDelete                         = { guifg = M.colors.base08, guibg = M.colors.base00, gui = nil, guisp = nil }
    hi.DiffText                           = { guifg = M.colors.base0D, guibg = M.colors.base00, gui = nil, guisp = nil }
    hi.DiffAdded                          = { guifg = M.colors.base0B, guibg = M.colors.base00, gui = nil, guisp = nil }
    hi.DiffFile                           = { guifg = M.colors.base08, guibg = M.colors.base00, gui = nil, guisp = nil }
    hi.DiffNewFile                        = { guifg = M.colors.base0B, guibg = M.colors.base00, gui = nil, guisp = nil }
    hi.DiffLine                           = { guifg = M.colors.base0D, guibg = M.colors.base00, gui = nil, guisp = nil }
    hi.DiffRemoved                        = { guifg = M.colors.base08, guibg = M.colors.base00, gui = nil, guisp = nil }

    -- Git highlighting
    hi.gitcommitOverflow                  = { guifg = M.colors.base08, guibg = nil, gui = nil, guisp = nil }
    hi.gitcommitSummary                   = { guifg = M.colors.base0B, guibg = nil, gui = nil, guisp = nil }
    hi.gitcommitComment                   = { guifg = M.colors.base03, guibg = nil, gui = nil, guisp = nil }
    hi.gitcommitUntracked                 = { guifg = M.colors.base03, guibg = nil, gui = nil, guisp = nil }
    hi.gitcommitDiscarded                 = { guifg = M.colors.base03, guibg = nil, gui = nil, guisp = nil }
    hi.gitcommitSelected                  = { guifg = M.colors.base03, guibg = nil, gui = nil, guisp = nil }
    hi.gitcommitHeader                    = { guifg = M.colors.base0E, guibg = nil, gui = nil, guisp = nil }
    hi.gitcommitSelectedType              = { guifg = M.colors.base0D, guibg = nil, gui = nil, guisp = nil }
    hi.gitcommitUnmergedType              = { guifg = M.colors.base0D, guibg = nil, gui = nil, guisp = nil }
    hi.gitcommitDiscardedType             = { guifg = M.colors.base0D, guibg = nil, gui = nil, guisp = nil }
    hi.gitcommitBranch                    = { guifg = M.colors.base09, guibg = nil, gui = 'bold', guisp = nil }
    hi.gitcommitUntrackedFile             = { guifg = M.colors.base0A, guibg = nil, gui = nil, guisp = nil }
    hi.gitcommitUnmergedFile              = { guifg = M.colors.base08, guibg = nil, gui = 'bold', guisp = nil }
    hi.gitcommitDiscardedFile             = { guifg = M.colors.base08, guibg = nil, gui = 'bold', guisp = nil }
    hi.gitcommitSelectedFile              = { guifg = M.colors.base0B, guibg = nil, gui = 'bold', guisp = nil }

    -- GitGutter highlighting
    hi.GitGutterAdd                       = { guifg = M.colors.base0B, guibg = M.colors.base00, gui = nil, guisp = nil }
    hi.GitGutterChange                    = { guifg = M.colors.base0D, guibg = M.colors.base00, gui = nil, guisp = nil }
    hi.GitGutterDelete                    = { guifg = M.colors.base08, guibg = M.colors.base00, gui = nil, guisp = nil }
    hi.GitGutterChangeDelete              = { guifg = M.colors.base0E, guibg = M.colors.base00, gui = nil, guisp = nil }

    -- Spelling highlighting
    hi.SpellBad                           = { guifg = nil, guibg = nil, gui = 'undercurl', guisp = M.colors.base08 }
    hi.SpellLocal                         = { guifg = nil, guibg = nil, gui = 'undercurl', guisp = M.colors.base0C }
    hi.SpellCap                           = { guifg = nil, guibg = nil, gui = 'undercurl', guisp = M.colors.base0D }
    hi.SpellRare                          = { guifg = nil, guibg = nil, gui = 'undercurl', guisp = M.colors.base0E }

    hi.DiagnosticError                    = { guifg = M.colors.base08, guibg = nil, gui = 'none', guisp = nil }
    hi.DiagnosticWarn                     = { guifg = M.colors.base0E, guibg = nil, gui = 'none', guisp = nil }
    hi.DiagnosticInfo                     = { guifg = M.colors.base05, guibg = nil, gui = 'none', guisp = nil }
    hi.DiagnosticHint                     = { guifg = M.colors.base0C, guibg = nil, gui = 'none', guisp = nil }
    hi.DiagnosticUnderlineError           = { guifg = nil, guibg = nil, gui = 'undercurl', guisp = M.colors.base08 }
    hi.DiagnosticUnderlineWarning         = { guifg = nil, guibg = nil, gui = 'undercurl', guisp = M.colors.base0E }
    hi.DiagnosticUnderlineWarn            = { guifg = nil, guibg = nil, gui = 'undercurl', guisp = M.colors.base0E }
    hi.DiagnosticUnderlineInformation     = { guifg = nil, guibg = nil, gui = 'undercurl', guisp = M.colors.base0F }
    hi.DiagnosticUnderlineHint            = { guifg = nil, guibg = nil, gui = 'undercurl', guisp = M.colors.base0C }

    hi.LspReferenceText                   = { guifg = nil, guibg = nil, gui = 'underline', guisp = M.colors.base04 }
    hi.LspReferenceRead                   = { guifg = nil, guibg = nil, gui = 'underline', guisp = M.colors.base04 }
    hi.LspReferenceWrite                  = { guifg = nil, guibg = nil, gui = 'underline', guisp = M.colors.base04 }
    hi.LspDiagnosticsDefaultError         = 'DiagnosticError'
    hi.LspDiagnosticsDefaultWarning       = 'DiagnosticWarn'
    hi.LspDiagnosticsDefaultInformation   = 'DiagnosticInfo'
    hi.LspDiagnosticsDefaultHint          = 'DiagnosticHint'
    hi.LspDiagnosticsUnderlineError       = 'DiagnosticUnderlineError'
    hi.LspDiagnosticsUnderlineWarning     = 'DiagnosticUnderlineWarning'
    hi.LspDiagnosticsUnderlineInformation = 'DiagnosticUnderlineInformation'
    hi.LspDiagnosticsUnderlineHint        = 'DiagnosticUnderlineHint'

    hi.TSAnnotation                       = { guifg = M.colors.base0F, guibg = nil, gui = 'none', guisp = nil }
    hi.TSAttribute                        = { guifg = M.colors.base0A, guibg = nil, gui = 'none', guisp = nil }
    hi.TSBoolean                          = { guifg = M.colors.base09, guibg = nil, gui = 'none', guisp = nil }
    hi.TSCharacter                        = { guifg = M.colors.base08, guibg = nil, gui = 'none', guisp = nil }
    hi.TSComment                          = { guifg = M.colors.base03, guibg = nil, gui = 'italic', guisp = nil }
    hi.TSConstructor                      = { guifg = M.colors.base0D, guibg = nil, gui = 'none', guisp = nil }
    hi.TSConditional                      = { guifg = M.colors.base0E, guibg = nil, gui = 'none', guisp = nil }
    hi.TSConstant                         = { guifg = M.colors.base09, guibg = nil, gui = 'none', guisp = nil }
    hi.TSConstBuiltin                     = { guifg = M.colors.base09, guibg = nil, gui = 'italic', guisp = nil }
    hi.TSConstMacro                       = { guifg = M.colors.base08, guibg = nil, gui = 'none', guisp = nil }
    hi.TSError                            = { guifg = M.colors.base08, guibg = nil, gui = 'none', guisp = nil }
    hi.TSException                        = { guifg = M.colors.base08, guibg = nil, gui = 'none', guisp = nil }
    hi.TSField                            = { guifg = M.colors.base05, guibg = nil, gui = 'none', guisp = nil }
    hi.TSFloat                            = { guifg = M.colors.base09, guibg = nil, gui = 'none', guisp = nil }
    hi.TSFunction                         = { guifg = M.colors.base0D, guibg = nil, gui = 'none', guisp = nil }
    hi.TSFuncBuiltin                      = { guifg = M.colors.base0D, guibg = nil, gui = 'italic', guisp = nil }
    hi.TSFuncMacro                        = { guifg = M.colors.base08, guibg = nil, gui = 'none', guisp = nil }
    hi.TSInclude                          = { guifg = M.colors.base0D, guibg = nil, gui = 'none', guisp = nil }
    hi.TSKeyword                          = { guifg = M.colors.base0E, guibg = nil, gui = 'none', guisp = nil }
    hi.TSKeywordFunction                  = { guifg = M.colors.base0E, guibg = nil, gui = 'none', guisp = nil }
    hi.TSKeywordOperator                  = { guifg = M.colors.base0E, guibg = nil, gui = 'none', guisp = nil }
    hi.TSLabel                            = { guifg = M.colors.base0A, guibg = nil, gui = 'none', guisp = nil }
    hi.TSMethod                           = { guifg = M.colors.base0D, guibg = nil, gui = 'none', guisp = nil }
    hi.TSNamespace                        = { guifg = M.colors.base08, guibg = nil, gui = 'none', guisp = nil }
    hi.TSNone                             = { guifg = M.colors.base05, guibg = nil, gui = 'none', guisp = nil }
    hi.TSNumber                           = { guifg = M.colors.base09, guibg = nil, gui = 'none', guisp = nil }
    hi.TSOperator                         = { guifg = M.colors.base05, guibg = nil, gui = 'none', guisp = nil }
    hi.TSParameter                        = { guifg = M.colors.base05, guibg = nil, gui = 'none', guisp = nil }
    hi.TSParameterReference               = { guifg = M.colors.base05, guibg = nil, gui = 'none', guisp = nil }
    hi.TSProperty                         = { guifg = M.colors.base05, guibg = nil, gui = 'none', guisp = nil }
    hi.TSPunctDelimiter                   = { guifg = M.colors.base0F, guibg = nil, gui = 'none', guisp = nil }
    hi.TSPunctBracket                     = { guifg = M.colors.base05, guibg = nil, gui = 'none', guisp = nil }
    hi.TSPunctSpecial                     = { guifg = M.colors.base05, guibg = nil, gui = 'none', guisp = nil }
    hi.TSRepeat                           = { guifg = M.colors.base0E, guibg = nil, gui = 'none', guisp = nil }
    hi.TSString                           = { guifg = M.colors.base0B, guibg = nil, gui = 'none', guisp = nil }
    hi.TSStringRegex                      = { guifg = M.colors.base0C, guibg = nil, gui = 'none', guisp = nil }
    hi.TSStringEscape                     = { guifg = M.colors.base0C, guibg = nil, gui = 'none', guisp = nil }
    hi.TSSymbol                           = { guifg = M.colors.base0B, guibg = nil, gui = 'none', guisp = nil }
    hi.TSTag                              = { guifg = M.colors.base0A, guibg = nil, gui = 'none', guisp = nil }
    hi.TSTagDelimiter                     = { guifg = M.colors.base0F, guibg = nil, gui = 'none', guisp = nil }
    hi.TSText                             = { guifg = M.colors.base05, guibg = nil, gui = 'none', guisp = nil }
    hi.TSStrong                           = { guifg = nil, guibg = nil, gui = 'bold', guisp = nil }
    hi.TSEmphasis                         = { guifg = M.colors.base09, guibg = nil, gui = 'italic', guisp = nil }
    hi.TSUnderline                        = { guifg = M.colors.base00, guibg = nil, gui = 'underline', guisp = nil }
    hi.TSStrike                           = { guifg = M.colors.base00, guibg = nil, gui = 'strikethrough', guisp = nil }
    hi.TSTitle                            = { guifg = M.colors.base0D, guibg = nil, gui = 'none', guisp = nil }
    hi.TSLiteral                          = { guifg = M.colors.base09, guibg = nil, gui = 'none', guisp = nil }
    hi.TSURI                              = { guifg = M.colors.base09, guibg = nil, gui = 'underline', guisp = nil }
    hi.TSType                             = { guifg = M.colors.base0A, guibg = nil, gui = 'none', guisp = nil }
    hi.TSTypeBuiltin                      = { guifg = M.colors.base0A, guibg = nil, gui = 'italic', guisp = nil }
    hi.TSVariable                         = { guifg = M.colors.base08, guibg = nil, gui = 'none', guisp = nil }
    hi.TSVariableBuiltin                  = { guifg = M.colors.base08, guibg = nil, gui = 'italic', guisp = nil }

    hi.TSDefinition                       = { guifg = nil, guibg = nil, gui = 'underline', guisp = M.colors.base04 }
    hi.TSDefinitionUsage                  = { guifg = nil, guibg = nil, gui = 'underline', guisp = M.colors.base04 }
    hi.TSCurrentScope                     = { guifg = nil, guibg = nil, gui = 'bold', guisp = nil }

    hi.LspInlayHint                       = { guifg = M.colors.base03, guibg = nil, gui = 'italic', guisp = nil }

    hi['@comment'] = 'TSComment'
    hi['@error'] = 'TSError'
    hi['@none'] = 'TSNone'
    hi['@preproc'] = 'PreProc'
    hi['@define'] = 'Define'
    hi['@operator'] = 'TSOperator'
    hi['@punctuation.delimiter'] = 'TSPunctDelimiter'
    hi['@punctuation.bracket'] = 'TSPunctBracket'
    hi['@punctuation.special'] = 'TSPunctSpecial'
    hi['@string'] = 'TSString'
    hi['@string.regex'] = 'TSStringRegex'
    hi['@string.escape'] = 'TSStringEscape'
    hi['@string.special'] = 'SpecialChar'
    hi['@character'] = 'TSCharacter'
    hi['@character.special'] = 'SpecialChar'
    hi['@boolean'] = 'TSBoolean'
    hi['@number'] = 'TSNumber'
    hi['@float'] = 'TSFloat'
    hi['@function'] = 'TSFunction'
    hi['@function.call'] = 'TSFunction'
    hi['@function.builtin'] = 'TSFuncBuiltin'
    hi['@function.macro'] = 'TSFuncMacro'
    hi['@method'] = 'TSMethod'
    hi['@method.call'] = 'TSMethod'
    hi['@constructor'] = 'TSConstructor'
    hi['@parameter'] = 'TSParameter'
    hi['@keyword'] = 'TSKeyword'
    hi['@keyword.function'] = 'TSKeywordFunction'
    hi['@keyword.operator'] = 'TSKeywordOperator'
    hi['@keyword.return'] = 'TSKeyword'
    hi['@conditional'] = 'TSConditional'
    hi['@repeat'] = 'TSRepeat'
    hi['@debug'] = 'Debug'
    hi['@label'] = 'TSLabel'
    hi['@include'] = 'TSInclude'
    hi['@exception'] = 'TSException'
    hi['@type'] = 'TSType'
    hi['@type.builtin'] = 'TSTypeBuiltin'
    hi['@type.qualifier'] = 'TSType'
    hi['@type.definition'] = 'TSType'
    hi['@storageclass'] = 'StorageClass'
    hi['@attribute'] = 'TSAttribute'
    hi['@field'] = 'TSField'
    hi['@property'] = 'TSProperty'
    hi['@variable'] = 'TSVariable'
    hi['@variable.builtin'] = 'TSVariableBuiltin'
    hi['@constant'] = 'TSConstant'
    hi['@constant.builtin'] = 'TSConstant'
    hi['@constant.macro'] = 'TSConstant'
    hi['@namespace'] = 'TSNamespace'
    hi['@symbol'] = 'TSSymbol'
    hi['@text'] = 'TSText'
    hi['@text.diff.add'] = 'DiffAdd'
    hi['@text.diff.delete'] = 'DiffDelete'
    hi['@text.strong'] = 'TSStrong'
    hi['@text.emphasis'] = 'TSEmphasis'
    hi['@text.underline'] = 'TSUnderline'
    hi['@text.strike'] = 'TSStrike'
    hi['@text.title'] = 'TSTitle'
    hi['@text.literal'] = 'TSLiteral'
    hi['@text.uri'] = 'TSUri'
    hi['@text.math'] = 'Number'
    hi['@text.environment'] = 'Macro'
    hi['@text.environment.name'] = 'Type'
    hi['@text.reference'] = 'TSParameterReference'
    hi['@text.todo'] = 'Todo'
    hi['@text.note'] = 'Tag'
    hi['@text.warning'] = 'DiagnosticWarn'
    hi['@text.danger'] = 'DiagnosticError'
    hi['@tag'] = 'TSTag'
    hi['@tag.attribute'] = 'TSAttribute'
    hi['@tag.delimiter'] = 'TSTagDelimiter'

    hi.NvimInternalError = { guifg = M.colors.base00, guibg = M.colors.base08, gui = 'none', guisp = nil }

    hi.NormalFloat       = { guifg = M.colors.base05, guibg = M.colors.base00, gui = nil, guisp = nil }
    hi.FloatBorder       = { guifg = M.colors.base05, guibg = M.colors.base00, gui = nil, guisp = nil }
    hi.NormalNC          = { guifg = M.colors.base05, guibg = M.colors.base00, gui = nil, guisp = nil }
    hi.TermCursor        = { guifg = M.colors.base00, guibg = M.colors.base05, gui = 'none', guisp = nil }
    hi.TermCursorNC      = { guifg = M.colors.base00, guibg = M.colors.base05, gui = nil, guisp = nil }

    hi.User1             = { guifg = M.colors.base08, guibg = M.colors.base02, gui = 'none', guisp = nil }
    hi.User2             = { guifg = M.colors.base0E, guibg = M.colors.base02, gui = 'none', guisp = nil }
    hi.User3             = { guifg = M.colors.base05, guibg = M.colors.base02, gui = 'none', guisp = nil }
    hi.User4             = { guifg = M.colors.base0C, guibg = M.colors.base02, gui = 'none', guisp = nil }
    hi.User5             = { guifg = M.colors.base05, guibg = M.colors.base02, gui = 'none', guisp = nil }
    hi.User6             = { guifg = M.colors.base05, guibg = M.colors.base01, gui = 'none', guisp = nil }
    hi.User7             = { guifg = M.colors.base05, guibg = M.colors.base02, gui = 'none', guisp = nil }
    hi.User8             = { guifg = M.colors.base00, guibg = M.colors.base02, gui = 'none', guisp = nil }
    hi.User9             = { guifg = M.colors.base00, guibg = M.colors.base02, gui = 'none', guisp = nil }

    hi.TreesitterContext = { guifg = nil, guibg = M.colors.base01, gui = 'italic', guisp = nil }

    if hex_re:match_str(M.colors.base00) and hex_re:match_str(M.colors.base01) and
        hex_re:match_str(M.colors.base02) then
        local darkerbg           = darken(M.colors.base00, 0.1)
        local darkercursorline   = darken(M.colors.base01, 0.1)
        local darkerstatusline   = darken(M.colors.base02, 0.1)
        hi.TelescopeBorder       = { guifg = darkerbg, guibg = darkerbg, gui = nil, guisp = nil }
        hi.TelescopePromptBorder = { guifg = darkerstatusline, guibg = darkerstatusline, gui = nil, guisp = nil }
        hi.TelescopePromptNormal = { guifg = M.colors.base05, guibg = darkerstatusline, gui = nil, guisp = nil }
        hi.TelescopePromptPrefix = { guifg = M.colors.base08, guibg = darkerstatusline, gui = nil, guisp = nil }
        hi.TelescopeNormal       = { guifg = nil, guibg = darkerbg, gui = nil, guisp = nil }
        hi.TelescopePreviewTitle = { guifg = darkercursorline, guibg = M.colors.base0B, gui = nil, guisp = nil }
        hi.TelescopePromptTitle  = { guifg = darkercursorline, guibg = M.colors.base08, gui = nil, guisp = nil }
        hi.TelescopeResultsTitle = { guifg = darkerbg, guibg = darkerbg, gui = nil, guisp = nil }
        hi.TelescopeSelection    = { guifg = nil, guibg = darkerstatusline, gui = nil, guisp = nil }
        hi.TelescopePreviewLine  = { guifg = nil, guibg = M.colors.base01, gui = 'none', guisp = nil }
    else
        hi.TelescopeBorder       = { guifg = M.colors.base05, guibg = M.colors.base00, gui = nil, guisp = nil }
        hi.TelescopePromptBorder = { guifg = M.colors.base05, guibg = M.colors.base00, gui = nil, guisp = nil }
        hi.TelescopePromptNormal = { guifg = M.colors.base05, guibg = M.colors.base00, gui = nil, guisp = nil }
        hi.TelescopePromptPrefix = { guifg = M.colors.base05, guibg = M.colors.base00, gui = nil, guisp = nil }
        hi.TelescopeNormal       = { guifg = nil, guibg = M.colors.base00, gui = nil, guisp = nil }
        hi.TelescopePreviewTitle = { guifg = M.colors.base01, guibg = M.colors.base0B, gui = nil, guisp = nil }
        hi.TelescopePromptTitle  = { guifg = M.colors.base01, guibg = M.colors.base08, gui = nil, guisp = nil }
        hi.TelescopeResultsTitle = { guifg = M.colors.base05, guibg = M.colors.base00, gui = nil, guisp = nil }
        hi.TelescopeSelection    = { guifg = nil, guibg = M.colors.base01, gui = nil, guisp = nil }
        hi.TelescopePreviewLine  = { guifg = nil, guibg = M.colors.base01, gui = 'none', guisp = nil }
    end


    hi.IndentBlanklineChar        = { guifg = M.colors.base02, gui = 'nocombine' }
    hi.IndentBlanklineContextChar = { guifg = M.colors.base04, gui = 'nocombine' }

    hi.CmpDocumentationBorder   = { guifg = M.colors.base05, guibg = M.colors.base00, gui = nil, guisp = nil }
    hi.CmpDocumentation         = { guifg = M.colors.base05, guibg = M.colors.base00, gui = nil, guisp = nil }
    hi.CmpItemAbbr              = { guifg = M.colors.base05, guibg = M.colors.base01, gui = nil, guisp = nil }
    hi.CmpItemAbbrDeprecated    = { guifg = M.colors.base03, guibg = nil, gui = 'strikethrough', guisp = nil }
    hi.CmpItemAbbrMatch         = { guifg = M.colors.base0D, guibg = nil, gui = nil, guisp = nil }
    hi.CmpItemAbbrMatchFuzzy    = { guifg = M.colors.base0D, guibg = nil, gui = nil, guisp = nil }
    hi.CmpItemKindDefault       = { guifg = M.colors.base05, guibg = nil, gui = nil, guisp = nil }
    hi.CmpItemMenu              = { guifg = M.colors.base04, guibg = nil, gui = nil, guisp = nil }
    hi.CmpItemKindKeyword       = { guifg = M.colors.base0E, guibg = nil, gui = nil, guisp = nil }
    hi.CmpItemKindVariable      = { guifg = M.colors.base08, guibg = nil, gui = nil, guisp = nil }
    hi.CmpItemKindConstant      = { guifg = M.colors.base09, guibg = nil, gui = nil, guisp = nil }
    hi.CmpItemKindReference     = { guifg = M.colors.base08, guibg = nil, gui = nil, guisp = nil }
    hi.CmpItemKindValue         = { guifg = M.colors.base09, guibg = nil, gui = nil, guisp = nil }
    hi.CmpItemKindFunction      = { guifg = M.colors.base0D, guibg = nil, gui = nil, guisp = nil }
    hi.CmpItemKindMethod        = { guifg = M.colors.base0D, guibg = nil, gui = nil, guisp = nil }
    hi.CmpItemKindConstructor   = { guifg = M.colors.base0D, guibg = nil, gui = nil, guisp = nil }
    hi.CmpItemKindClass         = { guifg = M.colors.base0A, guibg = nil, gui = nil, guisp = nil }
    hi.CmpItemKindInterface     = { guifg = M.colors.base0A, guibg = nil, gui = nil, guisp = nil }
    hi.CmpItemKindStruct        = { guifg = M.colors.base0A, guibg = nil, gui = nil, guisp = nil }
    hi.CmpItemKindEvent         = { guifg = M.colors.base0A, guibg = nil, gui = nil, guisp = nil }
    hi.CmpItemKindEnum          = { guifg = M.colors.base0A, guibg = nil, gui = nil, guisp = nil }
    hi.CmpItemKindUnit          = { guifg = M.colors.base0A, guibg = nil, gui = nil, guisp = nil }
    hi.CmpItemKindModule        = { guifg = M.colors.base05, guibg = nil, gui = nil, guisp = nil }
    hi.CmpItemKindProperty      = { guifg = M.colors.base08, guibg = nil, gui = nil, guisp = nil }
    hi.CmpItemKindField         = { guifg = M.colors.base08, guibg = nil, gui = nil, guisp = nil }
    hi.CmpItemKindTypeParameter = { guifg = M.colors.base0A, guibg = nil, gui = nil, guisp = nil }
    hi.CmpItemKindEnumMember    = { guifg = M.colors.base0A, guibg = nil, gui = nil, guisp = nil }
    hi.CmpItemKindOperator      = { guifg = M.colors.base05, guibg = nil, gui = nil, guisp = nil }
    hi.CmpItemKindSnippet       = { guifg = M.colors.base04, guibg = nil, gui = nil, guisp = nil }

    -- hi.IlluminatedWordText  = { guifg = nil, guibg = nil, gui = 'underline', guisp = M.colors.base04 }
    -- hi.IlluminatedWordRead  = { guifg = nil, guibg = nil, gui = 'underline', guisp = M.colors.base04 }
    -- hi.IlluminatedWordWrite = { guifg = nil, guibg = nil, gui = 'underline', guisp = M.colors.base04 }

    hi['@class'] = 'TSType'
    hi['@struct'] = 'TSType'
    hi['@enum'] = 'TSType'
    hi['@enumMember'] = 'Constant'
    hi['@event'] = 'Identifier'
    hi['@interface'] = 'Structure'
    hi['@modifier'] = 'Identifier'
    hi['@regexp'] = 'TSStringRegex'
    hi['@typeParameter'] = 'Type'
    hi['@decorator'] = 'Identifier'


    vim.g.terminal_color_0  = M.colors.base00
    vim.g.terminal_color_1  = M.colors.base08
    vim.g.terminal_color_2  = M.colors.base0B
    vim.g.terminal_color_3  = M.colors.base0A
    vim.g.terminal_color_4  = M.colors.base0D
    vim.g.terminal_color_5  = M.colors.base0E
    vim.g.terminal_color_6  = M.colors.base0C
    vim.g.terminal_color_7  = M.colors.base05
    vim.g.terminal_color_8  = M.colors.base03
    vim.g.terminal_color_9  = M.colors.base08
    vim.g.terminal_color_10 = M.colors.base0B
    vim.g.terminal_color_11 = M.colors.base0A
    vim.g.terminal_color_12 = M.colors.base0D
    vim.g.terminal_color_13 = M.colors.base0E
    vim.g.terminal_color_14 = M.colors.base0C
    vim.g.terminal_color_15 = M.colors.base07

    vim.g.base16_gui00      = M.colors.base00
    vim.g.base16_gui01      = M.colors.base01
    vim.g.base16_gui02      = M.colors.base02
    vim.g.base16_gui03      = M.colors.base03
    vim.g.base16_gui04      = M.colors.base04
    vim.g.base16_gui05      = M.colors.base05
    vim.g.base16_gui06      = M.colors.base06
    vim.g.base16_gui07      = M.colors.base07
    vim.g.base16_gui08      = M.colors.base08
    vim.g.base16_gui09      = M.colors.base09
    vim.g.base16_gui0A      = M.colors.base0A
    vim.g.base16_gui0B      = M.colors.base0B
    vim.g.base16_gui0C      = M.colors.base0C
    vim.g.base16_gui0D      = M.colors.base0D
    vim.g.base16_gui0E      = M.colors.base0E
    vim.g.base16_gui0F      = M.colors.base0F
end

local colors = {
    comment = "#999999",
    comment_light = "#999999",
    contrast = "#191919",
    background = "none",
    black = "#121111",
    foreground = "#dfdddd",
    cursorline = "#333333",
    cursor = "#dfdddd",
    color0 = "#1b1b1b",
    color1 = "#dddddd",
    color2 = "#99c794",
    color3 = "#fac863",
    color5 = "#5fafd7",
    color4 = "#8097fb",
    color6 = "#99c794",
    color7 = "#b7b7b7",
    color8 = "#272727",
    color9 = "#ec5f67",
    color10 = "#99c794",
    color11 = "#f99157",
    color12 = "#c594c5",
    color13 = "#8250df",
    color14 = "#54aeff",
    color15 = "#d4d5d5",
}


M.setup({
    base00 = '#none', base01 = '#333333', base02 = '#3e4451', base03 = '#6c7891',
    base04 = '#565c64', base05 = '#dddddd', base06 = '#9a9bb3', base07 = '#c5c8e6',
    base08 = '#54aeff', base09 = '#fac863', base0A = '#8097fb', base0B = '#98c379',
    base0C = '#f99157', base0D = '#a8a6ff', base0E = '#c594c5', base0F = '#eeeeee',
})

vim.cmd("hi CursorLineNr guifg=#fac863")
vim.cmd("hi WhichKeyFloat guibg=#333333")
-- vim.cmd("hi NormalFloat guibg=#333333")
-- vim.cmd("hi LineNr guibg=#333333 guifg=#777777")
-- vim.cmd("hi SignColumn guibg=#333333")
