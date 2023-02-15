return require("packer").startup(function()
    use("wbthomason/packer.nvim")

    use("~/w/cargo.nvim")

    use("Alexis12119/nightly.nvim")
    use("kaiuri/onigiri.nvim")
    use("mhartington/oceanic-next")
    use("EdenEast/nightfox.nvim")
    use("NTBBloodbath/doom-one.nvim")
    use("arturgoms/moonbow.nvim")

    use({
        "lewis6991/impatient.nvim",
        config = function()
            require("impatient")
        end,
    })

    use("nvim-lua/plenary.nvim")
    use("nvim-lua/popup.nvim")
    use("kyazdani42/nvim-web-devicons")

    use("ThePrimeagen/harpoon")

    use("nvim-telescope/telescope.nvim")
    use("nvim-telescope/telescope-fzy-native.nvim")

    -- use({
    --     "nvim-telescope/telescope-frecency.nvim",
    --     config = function()
    --         require("telescope").load_extension("frecency")
    --     end,
    --     requires = { "kkharji/sqlite.lua" },
    -- })

    use("nvim-treesitter/nvim-treesitter", {
        run = ":TSUpdate",
    })
    use("p00f/nvim-ts-rainbow")
    -- use("nvim-treesitter/nvim-treesitter-context")

    -- use("TimUntersberger/neogit")
    -- use("tpope/vim-fugitive")

    use("mhartington/formatter.nvim")

    use("neovim/nvim-lspconfig")

    -- use({
    --     "folke/lsp-colors.nvim",
    --     config = function()
    --         require("lsp-colors").setup({
    --             Error = "#db4b4b",
    --             Warning = "#e0af68",
    --             Information = "#0db9d7",
    --             Hint = "#10B981",
    --         })
    --     end,
    -- })

    use({
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup({
                auto_preview = false,
                auto_fold = true,
            })
        end,
    })

    -- use("onsails/lspkind-nvim")

    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")
    use("hrsh7th/cmp-cmdline")
    use("hrsh7th/nvim-cmp")

    use("L3MON4D3/LuaSnip")
    use("saadparwaiz1/cmp_luasnip")

    -- use("mfussenegger/nvim-dap")
    -- use("rcarriga/nvim-dap-ui")

    use({
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = { "MunifTanjim/nui.nvim" },
        config = function() end,
    })

    -- use({
    --     "norcalli/nvim-colorizer.lua",
    --     config = function()
    --         require("colorizer").setup()
    --     end,
    -- })

    use("nvim-lualine/lualine.nvim")
    -- use("kdheepak/tabline.nvim")

    use({
        "terrortylor/nvim-comment",
        config = function()
            require("nvim_comment").setup()
        end,
    })

    use({
        "luukvbaal/stabilize.nvim",
        config = function()
            require("stabilize").setup()
        end,
    })

    use({
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()
        end,
    })

    use({
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup()
        end,
    })

    use({
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("indent_blankline").setup({
                show_current_context = true,
                show_current_context_start = false,
                show_current_context_start_on_current_line = false,
                show_end_of_line = true,
            })
        end,
    })

    use({
        "rmagatti/auto-session",
        config = function()
            require("auto-session").setup({
                log_level = "error",
            })
        end,
    })
end)
