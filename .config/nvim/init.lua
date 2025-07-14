vim.cmd('syntax enable')
vim.cmd('filetype plugin indent on')

vim.o.timeout = true
vim.o.timeoutlen = 300
vim.o.completeopt = "menuone,noselect"

vim.o.guicursor = "a:block"
vim.o.pumblend = 17
vim.o.wildmode = "longest:full"
vim.o.wildoptions = "pum"
vim.o.title = true
vim.o.autoread = true
vim.o.conceallevel = 0
vim.o.history = 9000
vim.o.undolevels = 2000
vim.o.lazyredraw = true
vim.o.wildignorecase = true
vim.o.wildignore =
    ".git,.hg,*.o,*.a,*.class,*.jar,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,*.pyc,*.pyo,**/cache/*,**/logs/*,**/target/*,*.hi,tags,**/dist/*,**/public/**/vendor/**,**/public/vendor/**,**/node_modules/**"
vim.o.path = vim.o.path .. "**"
vim.o.showmode = false
vim.o.showcmd = true
vim.o.showmatch = true
vim.o.number = true
-- vim.o.relativenumber = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hidden = true
vim.o.cursorline = true
vim.o.colorcolumn = "96"
vim.o.cursorlineopt = "number"
vim.o.equalalways = false
vim.o.splitright = true
vim.o.splitbelow = false
vim.o.autoindent = true
vim.o.cindent = true
vim.o.wrap = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = true
vim.o.breakindent = true
vim.o.showbreak = string.rep(" ", 3)
vim.o.linebreak = true
vim.o.foldmethod = "marker"
vim.o.foldlevel = 0
vim.o.modelines = 1
vim.o.belloff = "all"
-- vim.o.clipboard = "unnamedplus"
vim.o.inccommand = "split"
vim.o.mouse = vim.o.mouse .. "a"
-- vim.o.laststatus = 3
vim.o.shortmess = "aW"
-- vim.o.winbar = "%=%m\\ %f"
vim.o.errorbells = false
vim.o.smartindent = true
vim.o.swapfile = false
vim.o.backup = false
vim.o.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.o.undofile = true
vim.o.hlsearch = false
vim.o.incsearch = true
vim.o.termguicolors = true
vim.o.scrolloff = 8
vim.o.signcolumn = "yes"
-- vim.o.cmdheight = 2
vim.o.updatetime = 50
vim.o.list = true
-- vim.o.listchars = "eol:↴"
-- vim.o.fillchars = "eob: "
vim.o.formatoptions = ""

-- vim.cmd([[
--     set guioptions-=e
--     set guioptions+=!
--     set sessionoptions+=tabpages,globals
--     set shellcmdflag-=ic
-- ]])

function map(op, lhs, rhs, opts)
    opts = vim.tbl_extend("force", { noremap = true, silent = true }, opts or {})
    vim.keymap.set(op, lhs, rhs, opts)
end

-- map("n", "<space>g", "<cmd>!cargo fmt<cr>")

map({ "n", "v" }, "<>", "<nop>")
map({ "n", "v" }, "q:", "<nop>")
map({ "n", "v" }, "Q", "<nop>")

map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
map( "n", "<space>y", '"+y')
map( "n", "<space>p", '"+p')
map( "v", "<space>y", '"+y')
map( "v", "<space>p", '"+p')

map("n", "<space>w", "<c-w>w")

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
    -- {
    --     "folke/tokyonight.nvim",
    --     lazy = false,
    --     priority = 1000,
    --     opts = {},
    --     config = function()
    --         vim.cmd[[colorscheme tokyonight-night]]
    --     end,
    -- },
    -- {
    --     'saghen/blink.cmp',
    --     -- optional: provides snippets for the snippet source
    --     dependencies = { 'rafamadriz/friendly-snippets' },
    --
    --     -- use a release tag to download pre-built binaries
    --     version = '1.*',
    --     -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    --     -- build = 'cargo build --release',
    --     -- If you use nix, you can build from source using latest nightly rust with:
    --     -- build = 'nix run .#build-plugin',
    --
    --     ---@module 'blink.cmp'
    --     ---@type blink.cmp.Config
    --     opts = {
    --         -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
    --         -- 'super-tab' for mappings similar to vscode (tab to accept)
    --         -- 'enter' for enter to accept
    --         -- 'none' for no mappings
    --         --
    --         -- All presets have the following mappings:
    --         -- C-space: Open menu or open docs if already open
    --         -- C-n/C-p or Up/Down: Select next/previous item
    --         -- C-e: Hide menu
    --         -- C-k: Toggle signature help (if signature.enabled = true)
    --         --
    --         -- See :h blink-cmp-config-keymap for defining your own keymap
    --         keymap = { preset = 'enter' },
    --
    --         appearance = {
    --             -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
    --             -- Adjusts spacing to ensure icons are aligned
    --             nerd_font_variant = 'mono'
    --         },
    --
    --         -- (Default) Only show the documentation popup when manually triggered
    --         completion = { 
    --             documentation = { auto_show = false },
    --             menu = {
    --                 -- nvim-cmp style menu
    --                 draw = {
    --                     columns = {
    --                         { "label", "label_description", gap = 1 },
    --                         { "kind" }
    --                     },
    --                 }
    --             },
    --         },
    --
    --         -- Default list of enabled providers defined so that you can extend it
    --         -- elsewhere in your config, without redefining it, due to `opts_extend`
    --         sources = {
    --             default = { 'lsp', 'path', 'snippets', 'buffer' },
    --         },
    --
    --         -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
    --         -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
    --         -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
    --         --
    --         -- See the fuzzy documentation for more information
    --         fuzzy = { implementation = "prefer_rust_with_warning" },
    --     },
    --     opts_extend = { "sources.default" }
    -- },
    {
        'ThePrimeagen/harpoon',
        config = function()
            opts = { noremap = true, silent = true }

            vim.keymap.set("n", "<space>m", function()
                require("harpoon.mark").add_file()
            end, opts)
            vim.keymap.set("n", "<space>n", function()
                require("harpoon.ui").toggle_quick_menu()
            end, opts)

            -- vim.keymap.set("n", "<space>b", function()
            --     require("harpoon.ui").nav_next()
            -- end, opts)

            vim.keymap.set("n", "<space>h", function()
                require("harpoon.ui").nav_file(1)                  -- navigates to file 3
            end, opts)

            vim.keymap.set("n", "<space>j", function()
                require("harpoon.ui").nav_file(1)                  -- navigates to file 3
            end, opts)

            vim.keymap.set("n", "<space>k", function()
                require("harpoon.ui").nav_file(2)                  -- navigates to file 3
            end, opts)

            vim.keymap.set("n", "<space>l", function()
                require("harpoon.ui").nav_file(3)                  -- navigates to file 3
            end, opts)

            --
            -- you can also cycle the list in both directions
            --
            -- :lua require("harpoon.ui").nav_next()                   -- navigates to next mark
            -- :lua require("harpoon.ui").nav_prev()
        end,
    },
    -- {
    --     "folke/tokyonight.nvim",
    --     lazy = false,
    --     priority = 1000,
    --     config = function()
    --         vim.cmd"colorscheme tokyonight-night"
    --         vim.cmd"hi Normal guibg=none"
    --     end,
    -- },
    {
        "DingDean/wgsl.vim",
        lazy = false,
        priority = 1000,
    },
    -- {
    --     "rjshkhr/shadow.nvim",
    --     priority = 1000,
    --     config = function()
    --         vim.opt.termguicolors = true
    --         vim.cmd.colorscheme("shadow")
    --     end,
    -- },
    -- {
    --     "ej-shafran/compile-mode.nvim",
    --     tag = "v5.*",
    --     -- you can just use the latest version:
    --     -- branch = "latest",
    --     -- or the most up-to-date updates:
    --     -- branch = "nightly",
    --     dependencies = {
    --         "nvim-lua/plenary.nvim",
    --         -- if you want to enable coloring of ANSI escape codes in
    --         -- compilation output, add:
    --         -- { "m00qek/baleia.nvim", tag = "v1.3.0" },
    --     },
    --     config = function()
    --         ---@type CompileModeOpts
    --         vim.g.compile_mode = {
    --             -- to add ANSI escape code support, add:
    --             -- baleia_setup = true,
    --         }
    --     end
    -- },
    -- {
    --     dir = "~/workspace/scratch-buffer.nvim",
    --     name = "scratch-buffer",
    --     config = function()
    --         require("scratch-buffer").setup()
    --     end,
    -- },
    {
        dir = "~/workspace/console.nvim",
        name = "console",
    },
    {"sindrets/diffview.nvim"},
    -- {"nvim-tree/nvim-tree.lua"} ,
    -- {
    --     "nvim-treesitter/nvim-treesitter",
    --     config = function()
    --         pcall(require("nvim-treesitter.install").update { with_sync = true })
    --     end,
    -- },
    -- {
    --     'neovim/nvim-lspconfig',
    --     dependencies = { },
    --
    --     dependencies = {
    --         { "j-hui/fidget.nvim", opts = {} },
    --         "folke/neodev.nvim",
    --         'saghen/blink.cmp', 
    --     },
    -- },
    -- {
    --     "hrsh7th/nvim-cmp",
    --     dependencies = {
    --         "hrsh7th/cmp-nvim-lsp",
    --         "L3MON4D3/LuaSnip",
    --         "saadparwaiz1/cmp_luasnip",
    --     },
    -- },
    -- { 'L3MON4D3/LuaSnip' },
    -- {
    --     'hrsh7th/nvim-cmp',
    --     config = function ()
    --         require'cmp'.setup {
    --             snippet = {
    --                 expand = function(args)
    --                     require'luasnip'.lsp_expand(args.body)
    --                 end
    --             },
    --             sources = {
    --                 { name = 'luasnip' },
    --             },
    --         }
    --     end
    -- },
    -- { 'saadparwaiz1/cmp_luasnip' },
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
        "rmagatti/auto-session",
        opts = { log_level = "error" }
    },
    { "numToStr/Comment.nvim", opts = {} },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
            return vim.fn.executable "make" == 1
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        version = "*",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    {"folke/which-key.nvim", opts = { icons = { mappings = false }}},
    {"norcalli/nvim-colorizer.lua", opts = {}},
    {"ojroques/nvim-hardline", opts = { }},
}, {})

local colors = {
    -- none = "#0F1B22",
    none = "none",
    gray1 = "#343D46",
    gray2 = "#4F5B66",
    gray3 = "#65737E",
    gray4 = "#A7ADBA",
    gray5 = "#C0C5CE",
    gray6 = "#CDD3DE",
    white = "#dfdfdf",
    blue = "#61afef",
    orange = "#c99157",
    green = "#99C794",
    yellow = "#eAb863",
    -- blue = "#6699CC",
    purple = "#a494C5",
    cyan = "#5FB3B3",
    brown = "#A07967",
    magenta = "#64c6e3",
}

-- local colors = {
--     none = "none",
--     gray1 = "#343D46",
--     gray2 = "#4F5B66",
--     gray3 = "#65737E",
--     gray4 = "#A7ADBA",
--     gray5 = "#C0C5CE",
--     gray6 = "#CDD3DE",
--     white = "#D8DEE9",
--     blue = "#61afef",
--     orange = "#F99157",
--     green = "#99C794",
--     yellow = "#FAC863",
--     blue = "#6699CC",
--     purple = "#C594C5",
--     cyan = "#5FB3B3",
--     brown = "#AB7967",
-- }

-- base 00: #1B2B34
-- base 01: #343D46
-- base 02: #4F5B66
-- base 03: #65737E
-- base 04: #A7ADBA
-- base 05: #C0C5CE
-- base 06: #CDD3DE
-- base 07: #D8DEE9
-- base 08: #EC5f67
-- base 09: #F99157
-- base 0A: #FAC863
-- base 0B: #99C794
-- base 0C: #5FB3B3
-- base 0D: #6699CC
-- base 0E: #C594C5
-- base 0F: #AB7967

vim.o.background = "dark"

local function highlight(group, fg, bg, attrs)
    local command = 'hi ' .. group
    if fg then command = command .. ' guifg=' .. fg end
    if bg then command = command .. ' guibg=' .. bg end
    if attrs then command = command .. ' gui=' .. attrs end
    vim.cmd(command)
end

vim.cmd('colorscheme default')

highlight("Normal", colors.white, colors.none)
highlight("Visual", nil, colors.gray2)
highlight("Comment", colors.gray4, nil, "italic")
highlight("Constant", colors.blue, nil)
highlight("String", colors.green, nil)
highlight("Identifier", colors.cyan, nil)
highlight("Function", colors.cyan, nil)
highlight("Statement", colors.blue, nil)
highlight("PreProc", colors.purple, nil)
highlight("Type", colors.blue, nil)
highlight("Special", colors.yellow, nil)
highlight("Underlined", colors.purple, nil, "underline")
highlight("Todo", colors.blue, nil, "bold")

highlight("CursorLine", nil, colors.gray1)
highlight("CursorLineNr", colors.yellow, colors.gray1)

highlight("Search", colors.none, colors.purple)
highlight("IncSearch", colors.none, colors.green)

highlight("StatusLine", colors.white, colors.gray2)
highlight("StatusLineNC", colors.gray4, colors.gray2)
highlight("VertSplit", colors.gray3, nil)

highlight("Error", colors.blue, nil)
highlight("Warning", colors.purple, nil)

highlight("Boolean", colors.orange, nil)
highlight("Number", colors.orange, nil)
highlight("Operator", colors.blue, nil)
highlight("Type", colors.magenta, nil)
highlight("StorageClass", colors.brown, nil)

highlight("LineNr", colors.gray2, nil)

highlight("TabLine", colors.gray3, nil)
highlight("TabLineFill", colors.gray2, nil)
highlight("TabLineSel", colors.white, colors.gray2)

highlight("Pmenu", colors.white, colors.gray2)
highlight("PmenuSel", colors.white, colors.blue)
highlight("PmenuSbar", colors.gray3, nil)
highlight("PmenuThumb", colors.gray4, nil)

vim.cmd [[
  hi GitSignsAdd          guifg=#99C794 guibg=NONE gui=bold
  hi GitSignsChange       guifg=#eab813  guibg=NONE gui=italic
  hi GitSignsDelete       guifg=#dC5f67 guibg=NONE gui=bold
  hi GitSignsAddLn        guifg=#99C794 guibg=NONE
  hi GitSignsChangeLn     guifg=#eab813 guibg=NONE
  hi GitSignsDeleteLn     guifg=#dC5f67 guibg=NONE
]]

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

-- require("nvim-treesitter").setup {
--     -- Add languages to be installed here that you want installed for treesitter
--     ensure_installed = { "rust", "wgsl", "lua", "markdown", "markdown_inline", "elm", "http",  "javascript" },
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

-- local on_attach = function(client, bufnr)
--     client.server_capabilities.semanticTokensProvider = nil
--
--     local map = function(keys, func, desc)
--         if desc then
--             desc = "LSP: " .. desc
--         end
--
--         vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
--     end
--
--     map("<space>d", vim.lsp.buf.definition, "goto definition")
--     map("<space>r", vim.lsp.buf.rename, "rename")
--
--     map("<space>h", function() vim.lsp.buf.hover({
--         border = "single",
--     }) end, "hover")
--
--     map("<space>e", function() vim.diagnostic.open_float({
--         border = "single",
--         virtual_lines = true,
--         virtual_text = true,
--         underline = false,
--     }) end, "show error")
--     map("<space>ln", vim.diagnostic.goto_prev, "prev error")
--     map("<space>lp", vim.diagnostic.goto_next, "next error")
--
--     map("<space>lq", vim.diagnostic.setloclist, "error list")
--     map("<space>la", vim.lsp.buf.code_action, "[C]ode [A]ction")
--     map("<space>lr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
--
--     map("<space>lf", function(_)
--         vim.lsp.buf.format()
--     end, "Format buffer")
--
--     -- map("<space>li", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
--     -- map("<space>ld", vim.lsp.buf.type_definition, "Type [D]efinition")
--     -- map("<space>ls", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
--     -- map("<space>lw", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
--
--     -- map("<space>k", vim.lsp.buf.signature_help, "Signature Documentation")
--
--     -- map("<space>d", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
--     -- map("<space>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
--     -- map("<space>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
--     -- map("<space>wl", function()
--     --     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--     -- end, "[W]orkspace [L]ist Folders")
-- end


-- require("neodev").setup()

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

-- local config = {
--     capabilities = capabilities,
-- }
--
-- local capabilities = require('blink.cmp').get_lsp_capabilities()
-- local lspconfig = require('lspconfig')
--
-- lspconfig['rust_analyzer'].setup({ 
--     on_attach = on_attach,
--     capabilities = capabilities 
--     -- handlers = handlers,
-- })
--
-- vim.diagnostic.config({
--   -- virtual_text = {
--   --   source = "if_many",
--   --   prefix = '● ',
--   -- },
--   virtual_text = true,
--   update_in_insert = true,
--   underline = true,
--   severity_sort = true,
--   float = {
--     focusable = false,
--     style = 'minimal',
--     border = 'rounded',
--     source = 'if_many',
--     header = '',
--     prefix = '',
--   },
-- })

local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = "*",
})

local hl_groups = vim.api.nvim_get_hl(0, {})

for key, hl_group in pairs(hl_groups) do
  if hl_group.italic then
    vim.api.nvim_set_hl(0, key, vim.tbl_extend("force", hl_group, {italic = false}))
  end
end
