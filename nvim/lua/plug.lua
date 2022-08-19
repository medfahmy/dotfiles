return require("packer").startup(function()
    use("wbthomason/packer.nvim")

    use("nvim-lua/plenary.nvim")
    use("nvim-lua/popup.nvim")

    use("nvim-telescope/telescope.nvim")

    use("nvim-treesitter/nvim-treesitter", {
        run = ":TSUpdate",
    })

    use("gruvbox-community/gruvbox")
    use("folke/tokyonight.nvim")
    use("mhartington/oceanic-next")

    use({
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup()
        end,
    })

    -- use({
    --     "kyazdani42/nvim-tree.lua",
    --     config = function()
    --         require("nvim-tree").setup({
    --             disable_netrw = true,
    --             hijack_unnamed_buffer_when_opening = false,
    --             reload_on_bufenter = true,
    --             open_on_setup = true,
    --         })
    --     end,
    -- })

    use("neovim/nvim-lspconfig")

    use("mhartington/formatter.nvim")

    use("kyazdani42/nvim-web-devicons")

    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")
    use("hrsh7th/cmp-cmdline")
    use("hrsh7th/nvim-cmp")

    use("onsails/lspkind-nvim")

    use("L3MON4D3/LuaSnip")
    use("saadparwaiz1/cmp_luasnip")

    use("nvim-lualine/lualine.nvim")
    use("kdheepak/tabline.nvim")

    use({
        "terrortylor/nvim-comment",
        config = function()
            require("nvim_comment").setup()
        end,
    })

    use({
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup()
            -- auto_preview = false,
            -- auto_fold = true,
            -- })
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
        "folke/lsp-colors.nvim",
        config = function()
            require("lsp-colors").setup({
                Error = "#db4b4b",
                Warning = "#e0af68",
                Information = "#0db9d7",
                Hint = "#10B981",
            })
        end,
    })

    use({
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup({})
        end,
    })

    use({
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("indent_blankline").setup({
                show_current_context = true,
                show_current_context_start = true,
                show_end_of_line = true,
            })
        end,
    })
end)
