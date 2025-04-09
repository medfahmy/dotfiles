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
        'ThePrimeagen/harpoon',
        config = function()
            opts = { noremap = true, silent = true }

            vim.keymap.set("n", "<space>m", function()
                require("harpoon.mark").add_file()
            end, opts)
            vim.keymap.set("n", "<space>n", function()
                require("harpoon.ui").toggle_quick_menu()
            end, opts)

            vim.keymap.set("n", "<space>b", function()
                require("harpoon.ui").nav_next()
            end, opts)

            -- :lua require("harpoon.ui").nav_file(3)                  -- navigates to file 3
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
    {"sindrets/diffview.nvim"},
    -- {"nvim-tree/nvim-tree.lua"} ,
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
    { 'L3MON4D3/LuaSnip' },
    {
        'hrsh7th/nvim-cmp',
        config = function ()
            require'cmp'.setup {
                snippet = {
                    expand = function(args)
                        require'luasnip'.lsp_expand(args.body)
                    end
                },
                sources = {
                    { name = 'luasnip' },
                },
            }
        end
    },
    { 'saadparwaiz1/cmp_luasnip' },
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
