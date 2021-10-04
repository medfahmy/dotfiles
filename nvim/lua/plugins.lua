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
  red = '#fb4934',
  darkred = '#cc241d',

  brightgreen = '#00ff00',
  brightyellow = '#ffff00',
  brightred = '#ff0000'
}

-- BARBAR

-- vim.g.bufferline = {
--   -- Enable/disable animations
--   animation = true,

--   -- Enable/disable auto-hiding the tab bar when there is a single buffer
--   auto_hide = true,

--   -- Enable/disable current/total tabpages indicator (top right corner)
--   tabpages = false,

--   -- Enable/disable close button
--   closable = true,

--   -- Enables/disable clickable tabs
--   --  - left-click: go to buffer
--   --  - middle-click: delete buffer
--   clickable = true,

--   -- Excludes buffers from the tabline
--   -- exclude_ft = ['javascript'],
--   -- exclude_name = ['package.json'],

--   -- Enable/disable icons
--   -- if set to 'numbers', will show buffer index in the tabline
--   -- if set to 'both', will show buffer index and icons in the tabline
--   icons = false,

--   -- If set, the icon color will follow its corresponding buffer
--   -- highlight group. By default, the Buffer*Icon group is linked to the
--   -- Buffer* group (see Highlighting below). Otherwise, it will take its
--   -- default value as defined by devicons.
--   icon_custom_colors = false,

--   -- Configure icons on the bufferline.
--   icon_separator_active = '▎',
--   icon_separator_inactive = '▎',
--   icon_close_tab = '',
--   icon_close_tab_modified = '●',
--   icon_pinned = '車',

--   -- If true, new buffers will be inserted at the end of the list.
--   -- Default is to insert after current buffer.
--   insert_at_end = true,

--   -- Sets the maximum padding width with which to surround each tab
--   maximum_padding = 1,

--   -- Sets the maximum buffer name length.
--   maximum_length = 30,

--   -- If set, the letters for each buffer in buffer-pick mode will be
--   -- assigned based on their name. Otherwise or in case all letters are
--   -- already assigned, the behavior is to assign letters in order of
--   -- usability (see order below)
--   semantic_letters = true,

--   -- New buffer letters are assigned in this order. This order is
--   -- optimal for the qwerty keyboard layout but might need adjustement
--   -- for other layouts.
--   letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',

--   -- Sets the name of unnamed buffers. By default format is "[Buffer X]"
--   -- where X is the buffer number. But only a static string is accepted here.
--   no_name_title = nil,
-- }


-- LUALINE

local custom_gruvbox = require'lualine.themes.gruvbox'
custom_gruvbox.normal.a.bg = colors.yellow
custom_gruvbox.normal.c.fg = colors.white
custom_gruvbox.insert.a.bg = colors.red
custom_gruvbox.visual.a.bg = colors.orange
custom_gruvbox.command.a.bg = colors.green

local function directory()
    return vim.api.nvim_exec('pwd', true)
end


require'lualine'.setup {
    options = {
        icons_enabled = true,
        padding = 1,
        -- theme = custom_gruvbox,
        -- theme = 'dracula',
        theme = 'tokyonight',
        section_separators = {'█'},
        component_separators = '▎',
        -- component_separators = {'', ''},
        -- section_separators = {'', ''},
        disabled_filetypes = {}
    },

    sections = {
        lualine_a = {'mode' },
        lualine_b = {
            'branch',
            {
                'diff',
                colored = true, -- displays diff status in color if set to true
                -- all colors are in format #rrggbb
                color_added = colors.brightgreen, -- changes diff's added foreground color
                color_modified = colors.brightyellow, -- changes diff's modified foreground color
                color_removed = colors.brightred, -- changes diff's removed foreground color
                symbols = {added = '+', modified = '~', removed = '-'} -- changes diff symbols
            }
        },
        lualine_c = {
            -- directory,
            {
                'filename',
                file_status = true,
                path = 1
            }
        },

        lualine_x = {
            {
                'diagnostics',
                sources = {'nvim_lsp'},
                -- symbols = {error = '', warn = '', info = ''},
                -- symbols = {error = 'x', warn = '!', info = '*'},
                color_error = colors.brightred,
                color_warn = colors.green,
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


-- TABLINE

require'tabline'.setup {
    enable = true,
    -- section_separators = {'', ''},
    -- component_separators = {'', ''},
    -- -- section_separators = {''},
    -- -- section_separators = {'█'},
    -- -- component_separators = {'|'},
    -- max_bufferline_percent = 66, -- set to nil by default, and it uses vim.o.columns * 2/3
    show_tabs_always = false, -- this shows tabs only when there are more than one tab or if the first tab is named
    -- show_devicons = false, -- this shows devicons in buffer section
    -- show_bufnr = false, -- this appends [bufnr] to buffer section,
    -- show_filename_only = true, -- shows base filename only instead of relative path in filename
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
        -- { name = 'buffer' }
    }
})


-- LSP

require'lspconfig'.tsserver.setup{
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
}

require'lspconfig'.graphql.setup{
  filetypes = {"graphql", "graphqls"}
}

-- require'lspconfig'.hls.setup{
-- 	on_attach = require'completion'.on_attach
-- }

require'lspconfig'.vimls.setup{
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
}

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


-- TREESITTER PARSERS

local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()

parser_configs.norg = {
    install_info = {
        url = "https://github.com/nvim-neorg/tree-sitter-norg",
        files = { "src/parser.c", "src/scanner.cc" },
        branch = "main"
    },
} 

local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
parser_configs.http = {
  install_info = {
    url = "https://github.com/NTBBloodbath/tree-sitter-http",
    files = { "src/parser.c" },
    branch = "main",
  },
}


-- TREESITTER

require'nvim-treesitter.configs'.setup {
    -- ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    ensure_installed = { "norg", "http", "typescript", "javascript", "tsx", "lua"},
    ignore_install = {}, -- List of parsers to ignore installing
    highlight = {
        enable = true,              -- false will disable the whole extension
        -- disable = {"tsx", "typescript", "javascript"},  -- list of language that will be disabled
        disable = {},
        -- disable = true,
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = true,
    },
    indent = {
        enable = false,
    },
    rainbow = {
        enable = true,
        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = nil, -- Do not enable for files with more than n lines, int
        -- colors = {}, -- table of hex strings
        -- termcolors = {} -- table of colour name strings
    },
    autotag = {
        enable = true,
        filetypes = {'html', 'javascript', 'javascriptreact', 'typescriptreact', 'svelte', 'tsx'}
    }
}

-- require "nvim-treesitter".setup()
-- require "nvim-treesitter.highlight"
-- local hlmap = vim.treesitter.TSHighlighter.hl_map

-- hlmap.error = nil

-- AUTOPAIRS

require('nvim-autopairs').setup({
  disable_filetype = { "Telesco, 'tsx'pePrompt" , "vim" },
})

require("nvim-autopairs.completion.cmp").setup({
  map_cr = true, --  map <CR> on insert mode
  map_complete = true, -- it will auto insert `(` (map_char) after select function or method item
  auto_select = true, -- automatically select the first item
  insert = false, -- use insert confirm behavior instead of replace
  map_char = { -- modifies the function or method delimiter by filetypes
    all = '(',
    tex = '{'
  }
})

--AUTOTAG

-- require('nvim-ts-autotag').setup()

-- NEORG



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


-- REST NVIM

require('rest-nvim').setup({
    -- Open request results in a horizontal split
    result_split_horizontal = false,
    -- Skip SSL verification, useful for unknown certificates
    skip_ssl_verification = false,
    -- Highlight request on run
    highlight = {
        enabled = true,
        timeout = 250,
    },
    -- Jump to request line on run
    jump_to_request = false,
})

-- NVIM-TREE

require'nvim-tree'.setup {
    -- disables netrw completely
    disable_netrw       = true,
    -- hijack netrw window on startup
    hijack_netrw        = true,
    -- open the tree when running this setup function
    open_on_setup       = false,
    -- will not open on setup if the filetype is in this list
    ignore_ft_on_setup  = { 'startify' },
    -- closes neovim automatically when the tree is the last **WINDOW** in the view
    auto_close          = true,
    -- opens the tree when changing/opening a new tab if the tree wasn't previously opened
    open_on_tab         = true,
    -- hijack the cursor in the tree to put it at the start of the filename
    hijack_cursor       = false,
    -- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually) 
    update_cwd          = false,
    -- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
    update_focused_file = {
        -- enables the feature
        enable      = false,
        -- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
        -- only relevant when `update_focused_file.enable` is true
        update_cwd  = false,
        -- list of buffer names / filetypes that will not update the cwd if the file isn't found under the current root directory
        -- only relevant when `update_focused_file.update_cwd` is true and `update_focused_file.enable` is true
        ignore_list = {}
    },
    -- configuration options for the system open command (`s` in the tree by default)
    system_open = {
        -- the command to run this, leaving nil should work in most cases
        cmd  = nil,
        -- the command arguments as a list
        args = {}
    },
}
