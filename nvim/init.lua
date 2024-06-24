vim.cmd[[set rtp^="/home/mohamed/.opam/ocaml5.1.1/share/ocp-indent/vim"]]

local o = vim.o

o.timeout = true
o.timeoutlen = 300
o.completeopt = "menuone,noselect"

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
o.listchars = "eol:↴"
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
    -- { "norcalli/nvim-colorizer.lua" },
    -- { "mfussenegger/nvim-dap" },
    -- { "rcarriga/nvim-dap-ui" },
    -- {
    --     "neovim/nvim-lspconfig",
    --     dependencies = {
    --         { "j-hui/fidget.nvim", opts = {} },
    --         "folke/neodev.nvim",
    --     },
    -- },
    -- {
    --     "hrsh7th/nvim-cmp",
    --     dependencies = {
    --         "hrsh7th/cmp-nvim-lsp",
    --     },
    -- },
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
                theme = "onedark",
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

require("telescope").setup()

pcall(require("telescope").load_extension, "fzf")

-- vim.keymap.set("n", "<space>g", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
vim.keymap.set("n", "<space>b", require("telescope.builtin").buffers, { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<space>/", function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
        winblend = 10,
        previewer = false,
    })
end, { desc = "[/] Fuzzily search in current buffer" })

vim.keymap.set("n", "<space>f", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<space>th", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<space>tw", require("telescope.builtin").grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<space>tg", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<space>td", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })

require("nvim-treesitter.configs").setup {
    -- Add languages to be installed here that you want installed for treesitter
    -- ensure_installed = { "c", "cpp", "go", "lua", "python", "rust", "tsx", "typescript", "vim", "markdown", "ocaml", "haskell" },

    -- ensure_installed

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

-- vim.keymap.set("n", "<space>[", vim.diagnostic.goto_prev)
-- vim.keymap.set("n", "<space>]", vim.diagnostic.goto_next)
-- vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
-- vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

-- local on_attach = function(_, bufnr)
--     local nmap = function(keys, func, desc)
--         if desc then
--             desc = "LSP: " .. desc
--         end
--
--         vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
--     end
--
--     nmap("<space>r", vim.lsp.buf.rename, "[R]e[n]ame")
--     nmap("<space>la", vim.lsp.buf.code_action, "[C]ode [A]ction")
--
--     nmap("<space>d", vim.lsp.buf.definition, "[G]oto [D]efinition")
--     nmap("<space>lr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
--     nmap("<space>li", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
--     nmap("<space>ld", vim.lsp.buf.type_definition, "Type [D]efinition")
--     nmap("<space>ls", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
--     nmap("<space>lw", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
--
--     nmap("<space>h", vim.lsp.buf.hover, "Hover Documentation")
--     nmap("<space>k", vim.lsp.buf.signature_help, "Signature Documentation")
--
--     nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
--     nmap("<space>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
--     nmap("<space>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
--     nmap("<space>wl", function()
--         print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--     end, "[W]orkspace [L]ist Folders")
--
--     nmap("<space>gf", function(_)
--         vim.lsp.buf.format()
--     end, "Format current buffer with LSP")
-- end


-- require("neodev").setup()

-- local lspconfig = require("lspconfig")

-- local capabilities = vim.lsp.protocol.make_client_capabilities()

-- local border = { " ", " ", " ", " ", " ", " ", " ", " " }

-- local handlers = {
--     ["textDocument/publishDiagnostics"] = vim.lsp.with(
--         vim.lsp.diagnostic.on_publish_diagnostics,
--         {
--             virtual_text = false,
--             underline = false,
--             float = {
--                 pad_top = 1,
--                 pad_bottom = 1,
--                 border = "single",
--             },
--         }
--     ),
--     ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
--         border = "single",
--     }),
--     ["textDocument/signatureHelp"] = vim.lsp.with(
--         vim.lsp.handlers.signature_help,
--         {
--             border = border,
--         }
--     ),
-- }

-- local config = {
--     on_attach = on_attach,
--     capabilities = capabilities,
--     handlers = handlers,
-- }

-- local servers = { "rust_analyzer", "tsserver" }

-- for _, server in ipairs(servers) do
--     lspconfig[server].setup(config)
-- end


-- local cmp = require "cmp"
--
-- cmp.setup {
--     mapping = cmp.mapping.preset.insert {
--         -- ["<C-d>"] = cmp.mapping.scroll_docs(-4),
--         -- ["<C-f>"] = cmp.mapping.scroll_docs(4),
--         ["<C-Space>"] = cmp.mapping.complete {},
--         ["<CR>"] = cmp.mapping.confirm {
--             behavior = cmp.ConfirmBehavior.Replace,
--             select = true,
--         },
--         -- ["<Tab>"] = cmp.mapping(function(fallback)
--         --     if cmp.visible() then
--         --         cmp.select_next_item()
--         --     else
--         --         fallback()
--         --     end
--         -- end, { "i", "s" }),
--         -- ["<S-Tab>"] = cmp.mapping(function(fallback)
--         --     if cmp.visible() then
--         --         cmp.select_prev_item()
--         --     else
--         --         fallback()
--         --     end
--         -- end, { "i", "s" }),
--     },
--     sources = {
--         { name = "nvim_lsp" },
--     },
-- }
--

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
map( "v", "<space>y", '"+y')
map( "v", "<space>p", '"+p')

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
-- map("n", "n", "nzzzv")
-- map("n", "N", "Nzzzv")
-- map("n", "J", "mzJ`z")
-- map("n", "<c-d>", "<c-d>zz")
-- map("n", "<c-u>", "<c-u>zz")
-- map("n", "{", "{zz")
-- map("n", "}", "}zz")

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


local colors = {
    comment = "#999999",
    comment_light = "#999999",
    contrast = "#191919",
    background = "none",
    black = "#121111",
    foreground = "#dfdddd",
    cursorline = "#111111",
    cursor = "#dfdddd",
    color0 = "#1b1b1b",
    color1 = "#dddddd",
    color2 = "#99c794",
    color3 = "#fac863",
    color5 = "#f99157",
    color12 = "#8097fb",
    color6 = "#99c794",
    color7 = "#b7b7b7",
    color8 = "#272727",
    color9 = "#ec5f67",
    color10 = "#99c794",
    color11 = "#c594c5",
    color14 = "#5fafd7",
    color13 = "#8250df",
    color4 = "#54aeff",
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
    CursorLine = { bg = colors.cursorline },
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
    ErrorMsg = { fg = colors.color9, bg = colors.background },
    Search = { fg = colors.background, bg = colors.color10 },
    IncSearch = { fg = colors.background, bg = colors.color11 },
    Substitute = { fg = colors.color3, bg = colors.color12 },
    MoreMsg = { fg = colors.color5 },
    Question = { fg = colors.color5 },
    EndOfBuffer = { fg = colors.background },
    NonText = { fg = "#666666" },
    Variable = { fg = colors.color5 },
    String = { fg = colors.color10 },
    Character = { fg = colors.color3 },
    Constant = { fg = colors.color4 },
    Number = { fg = colors.color3 },
    Boolean = { fg = colors.color3 },
    Float = { fg = colors.color3 },
    Identifier = { fg = colors.color1 },
    Function = { fg = colors.color4 },
    Operator = { fg = colors.color4 },
    Type = { fg = colors.color12 },
    StorageClass = { fg = colors.color3 },
    Structure = { fg = colors.color12 },
    Typedef = { fg = colors.color5 },
    Keyword = { fg = colors.color11 },
    Statement = { fg = colors.color5 },
    Conditional = { fg = colors.color11 },
    Repeat = { fg = colors.color11 },
    Label = { fg = colors.color12 },
    Exception = { fg = colors.color7 },
    Include = { fg = colors.color5 },
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
    Error = { fg = colors.color9, bg = colors.background },
    TabLine = { fg = colors.color2, bg = colors.background },
    TabLineSel = { fg = colors.foreground, bg = colors.background },
    TabLineFill = { fg = colors.foreground, bg = colors.background },
    IndentBlanklineChar = { fg = "#666666" },
    TelescopePromptNormal = {
        fg = colors.foreground,
        bg = colors.background,
    },
    TelescopePromptPrefix = {
        fg = colors.color1,
        bg = colors.color8,
    },
    TelescopeNormal = { bg = colors.background },
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
    -- TSAttribute = { fg = colors.color4 },
    -- TSBoolean = { fg = colors.color4 },
    -- TSCharacter = { fg = colors.color4 },
    -- TSComment = { fg = colors.comment, italic = true },
    -- TSConditional = { fg = colors.color11 },
    -- TSConstant = { fg = colors.color4 },
    -- TSConstBuiltin = { fg = colors.color4 },
    -- TSConstMacro = { fg = colors.color5 },
    -- TSConstructor = { fg = colors.color4 },
    -- TSException = { fg = colors.color8 },
    -- TSField = { fg = colors.color1 },
    -- TSFloat = { fg = colors.color8 },
    -- TSFunction = { fg = colors.color1 },
    -- TSFuncBuiltin = { fg = colors.color14 },
    -- TSFuncMacro = { fg = colors.color2 },
    -- TSInclude = { fg = colors.color9 },
    -- TSKeyword = { fg = colors.color11 },
    -- TSKeywordFunction = { fg = colors.color4 },
    -- TsKeywordOperator = { fg = colors.color4 },
    -- TSKeywordReturn = { fg = colors.color4 },
    -- TSLabel = { fg = colors.color4 },
    -- TSMethod = { fg = colors.color12 },
    -- TSNamespace = { fg = colors.color9 },
    -- TSNumber = { fg = colors.color3 },
    -- TSParameter = { fg = colors.color1 },
    -- TSParameterReference = { fg = colors.color9 },
    -- TSProperty = { fg = colors.color1 },
    -- TSPunctDelimiter = { fg = colors.color7 },
    -- TSPunctBracket = { fg = colors.color7 },
    -- TSPunctSpecial = { fg = colors.color7 },
    -- TSRepeat = { fg = colors.color11 },
    -- TSString = { fg = colors.color2 },
    -- TSStringRegex = { fg = colors.color2 },
    -- TSStringEscape = { fg = colors.color4 },
    -- TSStringSpecial = { fg = colors.color4 },
    -- TSSymbol = { fg = colors.color14 },
    -- TSTag = { fg = colors.color0 },
    -- TSTagAttribute = { fg = colors.color1 },
    -- TSTagDelimiter = { fg = colors.color7 },
    -- TSText = { fg = colors.color7 },
    -- TSStrong = { fg = colors.color7 },
    -- TSEmphasis = { italic = true, fg = colors.color7 },
    -- -- TSUnderline = { fg = colors.color5 },
    -- TSStrike = { fg = colors.color7 },
    -- TSTitle = { fg = colors.color3 },
    -- TSLiteral = { fg = colors.color2 },
    -- TSURI = { fg = colors.color3 },
    -- TSMath = { fg = colors.color4 },
    -- TSTextReference = { fg = colors.color12 },
    -- TSEnvirontment = { fg = colors.color5 },
    -- TSEnvironmentName = { fg = colors.color3 },
    -- TSNote = { fg = colors.color8 },
    -- TSWarning = { fg = colors.color0, bg = colors.color1 },
    -- TSDanger = { fg = colors.color8 },
    -- TSType = { fg = colors.color4 },
    -- TSTypeBuiltin = { fg = colors.color4 },
    -- TSVariable = { fg = colors.color7 },
    -- TSVariableBuiltin = { fg = colors.color4 },
}

for group, properties in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, properties)
end
