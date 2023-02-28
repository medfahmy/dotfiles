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
                icons_enabled = true,
                theme = "iceberg_dark",
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

-- options

vim.o.hlsearch = false
vim.wo.number = true
vim.o.mouse = "a"
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.wo.signcolumn = "yes"
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300
vim.o.completeopt = "menuone,noselect"
vim.o.termguicolors = true
vim.o.guicursor = "a:block"
vim.o.cursorline = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = true
vim.o.laststatus = 3
vim.o.scrolloff = 8

-- keymaps

vim.keymap.set(
    { "n", "v" },
    "<space>",
    "<nop>",
    { silent = true }
)
vim.keymap.set(
    { "n", "v" },
    "q:",
    "<nop>",
    { silent = true }
)
vim.keymap.set(
    { "n", "v" },
    "Q",
    "<nop>",
    { silent = true }
)

vim.keymap.set(
    'n',
    'k',
    "v:count == 0 ? 'gk' : 'k'",
    { expr = true, silent = true }
)
vim.keymap.set(
    'n',
    'j',
    "v:count == 0 ? 'gj' : 'j'",
    { expr = true, silent = true }
)

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
vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
vim.keymap.set("n", "<leader><space>", require("telescope.builtin").buffers, { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<leader>/", function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
        winblend = 10,
        previewer = false,
})
end, { desc = "[/] Fuzzily search in current buffer" })

vim.keymap.set("n", "<leader>sf", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sw", require("telescope.builtin").grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require("nvim-treesitter.configs").setup {
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = { "c", "cpp", "go", "lua", "python", "rust", "tsx", "typescript", "help", "vim" },

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
                ["<leader>a"] = "@parameter.inner",
            },
            swap_previous = {
                ["<leader>A"] = "@parameter.inner",
            },
        },
    },
}

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

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

    nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
    nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

    nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
    nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
    nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
    nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
    nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
    nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

-- See `:help K` for why this keymap
    nmap("K", vim.lsp.buf.hover, "Hover Documentation")
nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

-- Lesser used LSP functionality
    nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
    nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
    nmap("<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, "[W]orkspace [L]ist Folders")

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
        vim.lsp.buf.format()
    end, { desc = "Format current buffer with LSP" })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
    -- clangd = {},
    -- gopls = {},
    -- pyright = {},
    rust_analyzer = {},
    -- tsserver = {},
}

lua_ls = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
        },
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
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
luasnip.expand_or_jump()
            else
                fallback()
end
end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
},
    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
    },
}

local colors = {
    comment = "#999999",
    comment_light = "#999999",
    contrast = "#191919",
    background = "none",
    black = "#121111",
    foreground = "#dfdddd",
    cursorline = "#191919",
    cursor = "#dfdddd",
    color0 = "#1b1b1b",
    color1 = "#dddddd",
    color2 = "#99c794",
    color3 = "#fac863",
    color4 = "#5fafd7",
    color5 = "#c594c5",
    color6 = "#99c794",
    color7 = "#b7b7b7",
    color8 = "#272727",
    color9 = "#ec5f67",
    color10 = "#99c794",
    color11 = "#f99157",
    color12 = "#8097fb",
    color13 = "#8250df",
    color14 = "#54aeff",
    color15 = "#d4d5d5",
}

local highlights = {
    Normal = { fg = colors.foreground, bg = colors.background },
    SignColumn = { bg = colors.background, fg = colors.background },
    MsgArea = { fg = colors.foreground, bg = colors.background },
    ModeMsg = { fg = colors.foreground, bg = colors.background },
    MsgSeparator = { fg = colors.foreground, bg = colors.background },
    SpellBad = { fg = colors.color2 },
    SpellCap = { fg = colors.color12 },
    SpellLocal = { fg = colors.color12 },
    SpellRare = { fg = colors.color4 },
    NormalNC = { fg = colors.foreground, bg = colors.background },
    Pmenu = { fg = colors.foreground, bg = colors.background },
    PmenuSel = { fg = colors.black, bg = colors.color4 },
    WildMenu = { fg = colors.color7, bg = colors.color4 },
    CursorLineNr = { fg = colors.color3 },
    Comment = { fg = colors.comment, italic = true },
    Folded = { fg = colors.color4, bg = colors.background },
    FoldColumn = { fg = colors.color12, bg = colors.background },
    LineNr = { fg = "#555555", bg = colors.background },
    FloatBorder = { fg = colors.foreground, bg = colors.background },
    Whitespace = { fg = colors.color0 },
    VertSplit = { fg = colors.cursorline, bg = colors.background },
    CursorLine = { bg = colors.background },
    CursorColumn = { bg = colors.background },
    ColorColumn = { bg = colors.background },
    NormalFloat = { bg = colors.background },
    Visual = { bg = "#444444" },
    VisualNOS = { bg = colors.background },
    WarningMsg = { fg = colors.color3, bg = colors.background },
    DiffAdd = { bg = colors.background, fg = colors.color12 },
    DiffChange = { bg = colors.background, fg = colors.color5 },
    DiffDelete = { bg = colors.background, fg = colors.color1 },
    QuickFixLine = { bg = colors.color2 },
    PmenuSbar = { bg = colors.background },
    PmenuThumb = { bg = colors.color2 },
    MatchParen = { fg = colors.color12, bg = colors.background },
    Cursor = { fg = colors.comment, bg = colors.cursor },
    lCursor = { fg = colors.foreground, bg = colors.cursor },
    CursorIM = { fg = colors.foreground, bg = colors.cursor },
    TermCursor = { fg = colors.foreground, bg = colors.cursor },
    TermCursorNC = { fg = colors.foreground, bg = colors.cursor },
    Conceal = { fg = colors.color4, bg = colors.background },
    Directory = { fg = colors.color12 },
    SpecialKey = { fg = colors.color12 },
    Title = { fg = colors.color11 },
    ErrorMsg = { fg = colors.color1, bg = colors.background },
    Search = { fg = colors.background, bg = colors.color10 },
    IncSearch = { fg = colors.background, bg = colors.color11 },
    Substitute = { fg = colors.color3, bg = colors.color12 },
    MoreMsg = { fg = colors.color5 },
    Question = { fg = colors.color5 },
    EndOfBuffer = { fg = colors.background },
    NonText = { fg = "#666666" },
    Variable = { fg = colors.color5 },
    String = { fg = colors.color10 },
    Character = { fg = colors.color12 },
    Constant = { fg = colors.color12 },
    Number = { fg = colors.color12 },
    Boolean = { fg = colors.color5 },
    Float = { fg = colors.color12 },
    Identifier = { fg = colors.color1 },
    Function = { fg = colors.color12 },
    Operator = { fg = colors.color12 },
    Type = { fg = colors.color12 },
    StorageClass = { fg = colors.color3 },
    Structure = { fg = colors.color12 },
    Typedef = { fg = colors.color5 },
    Keyword = { fg = colors.color5 },
    Statement = { fg = colors.color5 },
    Conditional = { fg = colors.color1 },
    Repeat = { fg = colors.color5 },
    Label = { fg = colors.color12 },
    Exception = { fg = colors.color7 },
    Include = { fg = colors.color1 },
    PreProc = { fg = colors.color12 },
    Define = { fg = colors.color12 },
    Macro = { fg = colors.color12 },
    PreCondit = { fg = colors.color12 },
    Special = { fg = colors.color12 },
    SpecialChar = { fg = colors.color12 },
    Tag = { fg = colors.color15 },
    Debug = { fg = colors.color13 },
    Delimiter = { fg = colors.color7 },
    SpecialComment = { fg = colors.color8 },
    Ignore = { fg = colors.color7, bg = colors.background },
    Todo = { fg = colors.color1, bg = colors.background },
    Error = { fg = colors.color3, bg = colors.background },
    TabLine = { fg = colors.color2, bg = colors.background },
    TabLineSel = { fg = colors.foreground, bg = colors.background },
    TabLineFill = { fg = colors.foreground, bg = colors.background },
    IndentBlanklineChar = { fg = "#666666" },
    TelescopePromptNormal = {
        fg = colors.foreground,
        bg = colors.color8,
    },
    TelescopePromptPrefix = {
        fg = colors.color1,
        bg = colors.color8,
    },
    TelescopeNormal = { bg = colors.cursorline },
    TelescopePreviewTitle = {
        fg = colors.cursorline,
        bg = colors.cursorline,
    },
    TelescopePromptTitle = {
        fg = colors.background,
        bg = colors.color9,
    },
    TelescopeResultsTitle = {
        fg = colors.cursorline,
        bg = colors.cursorline,
    },
    TelescopeSelection = { bg = colors.color0, fg = colors.foreground },
    TelescopeResultsDiffAdd = {
        fg = colors.color10,
    },
    TelescopeResultsDiffChange = {
        fg = colors.color11,
    },
    TelescopeResultsDiffDelete = {
    fg = colors.color9,
    },
    GitSignsAdd = { fg = colors.color2 },
    GitSignsChange = { fg = colors.color5 },
    GitSignsDelete = { fg = colors.color1 },
    BufflineBufOnActive = { bg = colors.color4, fg = colors.background },
    BufflineBufOnInactive = { fg = colors.color7, bg = colors.contrast },
    BuffLineBufOnModified = { bg = colors.color4, fg = colors.background },
    BuffLineBufOnClose = { bg = colors.color4, fg = colors.background },
    BuffLineBufOffClose = { fg = colors.color9, bg = colors.contrast },
    BuffLineTree = { bg = colors.background, fg = colors.white },
    BuffLineEmpty = { bg = colors.background, fg = colors.white },
    TSAttribute = { fg = colors.color4 },
    TSBoolean = { fg = colors.color12 },
    TSCharacter = { fg = colors.color4 },
    TSComment = { fg = colors.comment, italic = true },
    TSConditional = { fg = colors.color1 },
    TSConstant = { fg = colors.color12 },
    TSConstBuiltin = { fg = colors.color4 },
    TSConstMacro = { fg = colors.color3 },
    TSConstructor = { fg = colors.color4 },
    TSException = { fg = colors.color8 },
    TSField = { fg = colors.color1 },
    TSFloat = { fg = colors.color8 },
    TSFunction = { fg = colors.color1 },
    TSFuncBuiltin = { fg = colors.color14 },
    TSFuncMacro = { fg = colors.color2 },
    TSInclude = { fg = colors.color9 },
    TSKeyword = { fg = colors.color5 },
    TSKeywordFunction = { fg = colors.color4 },
    TsKeywordOperator = { fg = colors.color12 },
    TSKeywordReturn = { fg = colors.color4 },
    TSLabel = { fg = colors.color4 },
    TSMethod = { fg = colors.color12 },
    TSNamespace = { fg = colors.color9 },
    TSNumber = { fg = colors.color3 },
    TSParameter = { fg = colors.color1 },
    TSParameterReference = { fg = colors.color9 },
    TSProperty = { fg = colors.color1 },
    TSPunctDelimiter = { fg = colors.color7 },
    TSPunctBracket = { fg = colors.color7 },
    TSPunctSpecial = { fg = colors.color7 },
    TSRepeat = { fg = colors.color11 },
    TSString = { fg = colors.color2 },
    TSStringRegex = { fg = colors.color2 },
    TSStringEscape = { fg = colors.color4 },
    TSStringSpecial = { fg = colors.color4 },
    TSSymbol = { fg = colors.color1 },
    TSTag = { fg = colors.color0 },
    TSTagAttribute = { fg = colors.color1 },
    TSTagDelimiter = { fg = colors.color7 },
    TSText = { fg = colors.color7 },
    TSStrong = { fg = colors.color7 },
    TSEmphasis = { italic = true, fg = colors.color7 },
    TSUnderline = { fg = colors.color5 },
    TSStrike = { fg = colors.color7 },
    TSTitle = { fg = colors.color3 },
    TSLiteral = { fg = colors.color2 },
    TSURI = { fg = colors.color3 },
    TSMath = { fg = colors.color12 },
    TSTextReference = { fg = colors.color12 },
    TSEnvirontment = { fg = colors.color5 },
    TSEnvironmentName = { fg = colors.color3 },
    TSNote = { fg = colors.color8 },
    TSWarning = { fg = colors.color0, bg = colors.color1 },
    TSDanger = { fg = colors.color8 },
    TSType = { fg = colors.color3 },
    TSTypeBuiltin = { fg = colors.color3 },
    TSVariable = { fg = colors.color7 },
    TSVariableBuiltin = { fg = colors.color4 },
}

function highlight()
    for group, properties in pairs(highlights) do
        vim.api.nvim_set_hl(0, group, properties)
    end
end

highlight()
