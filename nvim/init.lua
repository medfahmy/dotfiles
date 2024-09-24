require("opts")
vim.g.markdown_fenced_languages = {
  "ts=typescript"
}

-- vim.cmd('colorscheme default')
-- vim.cmd('hi Normal guibg=None')

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
    --     "tjdevries/colorbuddy.nvim",
    --     config = function()
    --         vim.cmd('colorscheme retrobox')
    --         vim.cmd('hi Normal guibg=None')
    --     end,
    -- },
    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            pcall(require("nvim-treesitter.install").update { with_sync = true })
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
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
        },
    },
    -- Installation
    -- use { 'L3MON4D3/LuaSnip' }
    -- use {
    --     'hrsh7th/nvim-cmp',
    --     config = function ()
    --         require'cmp'.setup {
    --             snippet = {
    --                 expand = function(args)
    --                     require'luasnip'.lsp_expand(args.body)
    --                 end
    --             },
    --
    --             sources = {
    --                 { name = 'luasnip' },
    --                 -- more sources
    --             },
    --         }
    --     end
    -- },
    -- use { 'saadparwaiz1/cmp_luasnip' }
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
        config = function()
            pcall(require("telescope").load_extension, "fzf")

            vim.keymap.set("n", "<space>o", require("telescope.builtin").oldfiles, { desc = "[?] find recently opened files" })
            vim.keymap.set("n", "<space>b", require("telescope.builtin").buffers, { desc = "[b] find existing buffers" })
            vim.keymap.set("n", "<space>/", function()
                -- you can pass additional configuration to telescope to change theme, layout, etc.
                require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
                    winblend = 10,
                    previewer = false,
                })
            end, { desc = "[/] fuzzily search in current buffer" })

            vim.keymap.set("n", "<space>f", require("telescope.builtin").find_files, { desc = "[f] find files" })
            vim.keymap.set("n", "<space>h", require("telescope.builtin").help_tags, { desc = "[h] find help" })
            vim.keymap.set("n", "<space>w", require("telescope.builtin").grep_string, { desc = "[w] find word by file" })
            vim.keymap.set("n", "<space>g", require("telescope.builtin").live_grep, { desc = "[f] find by grep" })
        end,
    },
    {"folke/which-key.nvim", opts = {}},
    {"norcalli/nvim-colorizer.lua", opts = {}},
    {"ojroques/nvim-hardline", opts = { }},
}, {})


require("g")
require("colors")
require("maps")

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

local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = "*",
})


