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
o.cursorlineopt = "number"
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
-- o.laststatus = 3
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

-- vim.cmd([[
--     set guioptions-=e
--     set guioptions+=!
--     set sessionoptions+=tabpages,globals
--     set shellcmdflag-=ic
-- ]])

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
        "projekt0n/github-nvim-theme",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            require("github-theme").setup()
            vim.cmd([[
                colorscheme github_dark_high_contrast
            ]])
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        -- opts = {
        --     signs = {
        --         add = { text = "+" },
        --         change = { text = "~" },
        --         delete = { text = "_" },
        --         topdelete = { text = "‾" },
        --         changedelete = { text = "~" },
        --     },
        -- },
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
    {"folke/which-key.nvim", opts = {}},
    {"norcalli/nvim-colorizer.lua", opts = {}},
    {"ojroques/nvim-hardline", opts = {}},
}, {})

local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = "*",
})

require('hardline').setup {
    bufferline = false,  -- disable bufferline
    bufferline_settings = {
        exclude_terminal = false,  -- don't show terminal buffers in bufferline
        show_index = false,        -- show buffer indexes (not the actual buffer numbers) in bufferline
    },
    theme = 'default',   -- change theme
    sections = {         -- define sections
        {class = 'mode', item = require('hardline.parts.mode').get_item},
        {class = 'high', item = require('hardline.parts.git').get_item, hide = 100},
        {class = 'high', item = require('hardline.parts.filename').get_item},
        '%<',
        {class = 'med', item = '%='},
        -- {class = 'high', item = require('hardline.parts.wordcount').get_item, hide = 100},
        -- {class = 'error', item = require('hardline.parts.lsp').get_error},
        -- {class = 'warning', item = require('hardline.parts.lsp').get_warning},
        -- {class = 'high', item = require('hardline.parts.whitespace').get_item},
        {class = 'high', item = require('hardline.parts.filetype').get_item, hide = 60},
        {class = 'low', item = require('hardline.parts.line').get_item},
    },
}

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
