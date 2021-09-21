-- COLOR TABLE 
local colors = {
  bg = '#202328',
  fg = '#bbc2cf',
  yellow = '#fabd2f',
  cyan = '#008080',
  darkblue = '#081633',
  green = '#b8bb26',
  orange = '#fe8019',
  violet = '#d3869b',
  magenta = '#c678dd',
  blue = '#51afef',
  red = '#fb4934'
}

-- BARBAR

vim.g.bufferline = {
  -- Enable/disable animations
  animation = true,

  -- Enable/disable auto-hiding the tab bar when there is a single buffer
  auto_hide = true,

  -- Enable/disable current/total tabpages indicator (top right corner)
  tabpages = true,

  -- Enable/disable close button
  closable = true,

  -- Enables/disable clickable tabs
  --  - left-click: go to buffer
  --  - middle-click: delete buffer
  clickable = true,

  -- Excludes buffers from the tabline
  -- exclude_ft = ['javascript'],
  -- exclude_name = ['package.json'],

  -- Enable/disable icons
  -- if set to 'numbers', will show buffer index in the tabline
  -- if set to 'both', will show buffer index and icons in the tabline
  icons = true,

  -- If set, the icon color will follow its corresponding buffer
  -- highlight group. By default, the Buffer*Icon group is linked to the
  -- Buffer* group (see Highlighting below). Otherwise, it will take its
  -- default value as defined by devicons.
  icon_custom_colors = false,

  -- Configure icons on the bufferline.
  icon_separator_active = '▎',
  icon_separator_inactive = '▎',
  icon_close_tab = '',
  icon_close_tab_modified = '●',
  icon_pinned = '車',

  -- If true, new buffers will be inserted at the end of the list.
  -- Default is to insert after current buffer.
  insert_at_end = true,

  -- Sets the maximum padding width with which to surround each tab
  maximum_padding = 1,

  -- Sets the maximum buffer name length.
  maximum_length = 30,

  -- If set, the letters for each buffer in buffer-pick mode will be
  -- assigned based on their name. Otherwise or in case all letters are
  -- already assigned, the behavior is to assign letters in order of
  -- usability (see order below)
  semantic_letters = true,

  -- New buffer letters are assigned in this order. This order is
  -- optimal for the qwerty keyboard layout but might need adjustement
  -- for other layouts.
  letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',

  -- Sets the name of unnamed buffers. By default format is "[Buffer X]"
  -- where X is the buffer number. But only a static string is accepted here.
  no_name_title = nil,
}


-- LUALINE

local custom_gruvbox = require'lualine.themes.gruvbox'
-- Change the background of lualine_c section for normal mode
custom_gruvbox.normal.a.bg = colors.yellow -- rgb colors are supported
custom_gruvbox.normal.c.fg = colors.white -- rgb colors are supported
custom_gruvbox.insert.a.bg = colors.red -- rgb colors are supported
custom_gruvbox.visual.a.bg = colors.orange -- rgb colors are supported
custom_gruvbox.command.a.bg = colors.green -- rgb colors are supported

require'lualine'.setup {
    options = {
        icons_enabled = false,
        theme = custom_gruvbox,
        -- theme = 'auto',
        section_separators = '',
        component_separators = '|',
        --component_separators = {'', ''},
        --section_separators = {'', ''},
        disabled_filetypes = {}
    },

    sections = {
        lualine_a = {'mode' },
        lualine_b = {
            'branch',
            'diff',
        },
        lualine_c = {
            {
                'filename',
                file_status = true,
                path = 2
            }
        },

        lualine_x = {
            {
                'diagnostics',
                sources = {'nvim_lsp'},
                symbols = {error = '', warn = '', info = ''},
                color_error = colors.red,
                color_warn = colors.yellow,
                color_info = colors.cyan
            },
            function()
                local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
                local clients = vim.lsp.get_active_clients()
                if next(clients) == nil then end
                for _, client in ipairs(clients) do
                    local filetypes = client.config.filetypes
                    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                        return client.name
                    end
                end
            end,
            color = {fg = '#ffffff'}
        },

        lualine_y = {
            {
                'filetype',
                colored=true
            }
        },

        lualine_z = {'location'}
    },

    tabline={
        -- lualine_a = {},
        -- lualine_b = {},
        -- lualine_c = { require'tabline'.tabline_buffers },
        -- lualine_x = { require'tabline'.tabline_tabs },
        -- lualine_y = {},
        -- lualine_z = {},
    },

    inactive_sections = {},

    extensions = {}
}

-- NVIM-CMP
local cmp = require'cmp'

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)

        end,
    },
    mapping = {
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' }),

    },
    sources = {
        { name = 'nvim_lsp' },

        { name = 'luasnip' },

        { name = 'buffer' }
    }
})


-- LSP

require'lspconfig'.tsserver.setup{
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
}

-- require'lspconfig'.graphql.setup{
--   filetypes = {"graphql", "graphqls"}
-- }

-- require'lspconfig'.hls.setup{
-- 	on_attach = require'completion'.on_attach
-- }

require'lspconfig'.vimls.setup{}

-- require'lspconfig'.rust_analyzer.setup{}

-- require'lspconfig'.gopls.setup{}


--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspconfig'.cssls.setup {
    capabilities = capabilities,
}

require'lspconfig'.html.setup {
    capabilities = capabilities,
}

require'lspconfig'.jsonls.setup {
    commands = {
        Format = {
            function()
                vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
            end
        }
    },
    capabilities = capabilities,
}

-- TELESCOPE

require('telescope').setup{
    defaults = {
        prompt_prefix ="> ",
        file_ignore_patterns = {"node_modules","dist","build",".git"}
    },
    pickers = {
        buffers = {
            sort_lastused = true,
            theme = "dropdown",
            previewer = false,
        },
        find_files = {
            theme = "dropdown",
            previewer = false,
            hidden = true
        },
        file_browser = {
            theme = "dropdown",
            previewer = false,
            hideen = false
        }
    }
}


-- LSP CONFIG

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    -- update_in_insert=true,
    signs=true
}
)

require("trouble").setup {
    icons=true
}




-- TREESITTER

require'nvim-treesitter.configs'.setup {
  autotag = {
    enable = true,
  },
  -- ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = { "norg", "typescript", "javascript", "tsx", "lua"},
  ignore_install = {}, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = {"tsx"},  -- list of language that will be disabled
    -- disable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = true,
  },
  indent = {
    enable = true,
  }
}

-- require "nvim-treesitter".setup()
-- require "nvim-treesitter.highlight"
-- local hlmap = vim.treesitter.TSHighlighter.hl_map

-- hlmap.error = nil



-- NEORG

local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()

parser_configs.norg = {
    install_info = {
        url = "https://github.com/nvim-neorg/tree-sitter-norg",
        files = { "src/parser.c", "src/scanner.cc" },
        branch = "main"
    },
} 

require('neorg').setup {
    -- Tell Neorg what modules to load
    load = {
        ["core.defaults"] = {}, -- Load all the default modules
        ["core.norg.concealer"] = {}, -- Allows for use of icons
        ["core.keybinds"] = { -- Configure core.keybinds
                    config = {
                        default_keybinds = true, -- Generate the default keybinds
                        neorg_leader = "<Leader>o" -- This is the default if unspecified
                    }
                },
        ["core.norg.dirman"] = { -- Manage your directories with Neorg
            config = {
                workspaces = {
                    my_workspace = "~/neorg"
                }
            }
        },
        ["core.norg.completion"] = { config = { engine = "nvim-cmp"  } }
    },
}
