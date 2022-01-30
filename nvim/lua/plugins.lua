-- This file can be loaded by calling `lua require('plugins')` from your init.vim

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
    use 'wbthomason/packer.nvim'

    use 'mhartington/oceanic-next'
    use 'drsooch/gruber-darker-vim'

    use 'mhartington/formatter.nvim'

    use 'dikiaap/minimalist'

    use 'neovim/nvim-lspconfig'
    use 'kabouzeid/nvim-lspinstall'
    use {
        'folke/lsp-colors.nvim',
        config = function()
            require("lsp-colors").setup({
              Error = "#db4b4b",
              Warning = "#e0af68",
              Information = "#0db9d7",
              Hint = "#10B981"
            })
        end
    }
    use 'folke/trouble.nvim'

    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/nvim-cmp'
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'
    use 'onsails/lspkind-nvim'

    use {
        'windwp/nvim-autopairs',
        config = function()
            require('nvim-autopairs').setup({
                disable_filetype = { "TelescopePrompt" },
                disable_in_macro = true,  -- disable when recording or executing a macro
                ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]],"%s+", ""),
                enable_moveright = true,
                enable_afterquote = true, -- add bracket pairs after quote
                enable_check_bracket_line = false, --- check bracket in same line,
                check_ts = false,
                map_bs = true, -- map the <BS> key
                map_c_w = true,-- map <c-w> to delete a pair if possible
                map_cr = true, -- without nvim-cmp
            })
        end
    }

    use 'norcalli/nvim-colorizer.lua'

    use {
      'nvim-telescope/telescope.nvim',
      requires = { {'nvim-lua/plenary.nvim'} }
    }

    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
          'kyazdani42/nvim-web-devicons', -- optional, for file icon
        },
        config = function() require'nvim-tree'.setup {} end
    }

    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    -- use 'windwp/nvim-ts-autotag' -- deprecated?

    use {
        'luukvbaal/stabilize.nvim',
        config = function()
            require'stabilize'.setup()
        end
    }

    use {
        'terrortylor/nvim-comment',
        config = function()
            require'nvim_comment'.setup()
            vim.cmd([[
                nnoremap <silent> <c-_> :CommentToggle<cr>
                vnoremap <silent> <c-_> :'<,'>CommentToggle<cr>
            ]])
        end
    }

    use {
      "NTBBloodbath/rest.nvim",
      requires = { "nvim-lua/plenary.nvim" },
      config = function()
        require("rest-nvim").setup({
          -- Open request results in a horizontal split
          result_split_horizontal = false,
          -- Skip SSL verification, useful for unknown certificates
          skip_ssl_verification = false,
          -- Highlight request on run
          highlight = {
            enabled = true,
            timeout = 150,
          },
          result = {
            -- toggle showing URL, HTTP info, headers at top the of result window
            show_url = true,
            show_http_info = true,
            show_headers = true,
          },
          -- Jump to request line on run
          jump_to_request = false,
          env_file = '.env',
          custom_dynamic_variables = {},
        })
        vim.cmd("nnoremap <leader>rs <cmd>lua require('rest-nvim').run() <cr>")

      end
    }

    use {
        'nvim-lualine/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }
    use 'kdheepak/tabline.nvim'

end)

