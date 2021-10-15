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

require'nvim_comment'.setup()
require'colorizer'.setup()

require'indent_blankline'.setup {
    char = '▏',
    buftype_exclude = {'terminal', 'startify', 'TelescopePrompt'}
}

-- LUALINE

-- local custom_gruvbox = require 'lualine.themes.gruvbox'
-- custom_gruvbox.normal.a.bg = colors.yellow
-- custom_gruvbox.normal.c.fg = colors.white
-- custom_gruvbox.insert.a.bg = colors.red
-- custom_gruvbox.visual.a.bg = colors.orange
-- custom_gruvbox.command.a.bg = colors.green

require'lualine'.setup {
    options = {
        icons_enabled = true,
        padding = 1,
        theme = 'material',
        section_separators = {'█'},
        component_separators = '▎',
        -- component_separators = {'', ''},
        -- section_separators = {'', ''},
        disabled_filetypes = {}
    },
    sections = {
        lualine_a = {'mode'},
        lualine_c = {
            'branch', {
                'diff',
                colored = true, -- displays diff status in color if set to true
                -- all colors are in format #rrggbb
                color_added = colors.brightgreen, -- changes diff's added foreground color
                color_modified = colors.brightyellow, -- changes diff's modified foreground color
                color_removed = colors.brightred, -- changes diff's removed foreground color
                symbols = {
                    added = '+',
                    modified = '~',
                    removed = '-'
                } -- changes diff symbols
            }
        },
        lualine_b = {
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
            color = {
                fg = '#ffffff'
            }
        },
        lualine_y = {
            {
                'filetype',
                colored = true
            }
        },
        lualine_z = {'location'}
    }
}

-- TABLINE

require'tabline'.setup {
    enable = true,
    show_tabs_always = true, -- this shows tabs only when there are more than one tab or if the first tab is named
    show_devicons = true -- this shows devicons in buffer section
    -- show_bufnr = false, -- this appends [bufnr] to buffer section,
    -- show_filename_only = true, -- shows base filename only instead of relative path in filename
}

-- NVIM-CMP
local lspkind = require('lspkind')
local cmp = require 'cmp'

cmp.setup({
    formatting = {
        format = lspkind.cmp_format({
            with_text = false,
            maxwidth = 50
        })
    },
    snippet = {
        expand = function(args) require('luasnip').lsp_expand(args.body) end
    },
    mapping = {
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({
            select = true
        }),
        ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'}),
        ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})
    },
    sources = {
        {
            name = 'nvim_lsp'
        }, {
            name = 'luasnip'
        }
    },
    experimental = {
        native_menu = false,
        ghost_text = true
    }
})

-- LSP

require'lspconfig'.tsserver.setup {
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
}

require'lspconfig'.graphql.setup {
    filetypes = {'graphql', 'graphqls'}
}

require'lspconfig'.hls.setup {
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
}

require'lspconfig'.vimls.setup {
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()) 
}

require'lspconfig'.rust_analyzer.setup {}

-- require'lspconfig'.gopls.setup{}

-- Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspconfig'.cssls.setup {
    capabilities = capabilities
}

require'lspconfig'.html.setup {
    capabilities = capabilities
}

require'lspconfig'.jsonls.setup {
    commands = {
        Format = {
            function()
                vim.lsp.buf.range_formatting({}, {0, 0}, {vim.fn.line('$'), 0})
            end
        }
    },
    capabilities = capabilities
}

-- TELESCOPE

require('telescope').setup {
    defaults = {
        prompt_prefix = '>> ',
        file_ignore_patterns = {'node_modules', 'dist', 'build', '.git'}
    },
    pickers = {
        buffers = {
            -- theme = 'dropdown',
            -- sort_lastused = true,
            previewer = false,
        },
        find_files = {
            -- theme = 'dropdown',
            hidden = true,
            previewer = false,
        },
        file_browser = {
            -- theme = 'dropdown',
            sort_lastused = true,
            hidden = true,
            previewer = false,
        },
        live_grep = {
            theme = 'dropdown',
            -- sort_lastused = true,
            hidden = true
        }
    }
}

-- LSP CONFIG

vim.lsp.handlers['textDocument/publishDiagnostics'] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false,
        update_in_insert = false,
        underline = false,
        signs = true
    })

require('trouble').setup {
    icons = true
}

-- TREESITTER PARSERS

-- local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()
-- 
-- parser_configs.norg = {
--     install_info = {
--         url = 'https://github.com/nvim-neorg/tree-sitter-norg',
--         files = {'src/parser.c', 'src/scanner.cc'},
--         branch = 'main'
--     }
-- }

local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()
parser_configs.http = {
    install_info = {
        url = 'https://github.com/NTBBloodbath/tree-sitter-http',
        files = {'src/parser.c'},
        branch = 'main'
    }
}

-- TREESITTER

require'nvim-treesitter.configs'.setup {
    -- ensure_installed = 'all', -- one of 'all', 'maintained' (parsers with maintainers), or a list of languages
    ensure_installed = {
        'typescript', 'javascript', 'tsx', 'lua', 'haskell', 'http'
    },
    ignore_install = {}, -- List of parsers to ignore installing
    highlight = {
        enable = true,
        -- disable = {'tsx', 'typescript'}, -- list of language that will be disabled
        disable = {},
        -- disable = true,
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = true
    },
    indent = {
        enable = false
    },
    rainbow = {
        enable = true,
        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = nil -- Do not enable for files with more than n lines, int
        -- colors = {}, -- table of hex strings
        -- termcolors = {} -- table of colour name strings
    },
    autotag = {
        enable = true,
        filetypes = {
            'html', 'javascript', 'javascriptreact', 'typescriptreact',
            'svelte', 'tsx'
        }
    }
}

-- require 'nvim-treesitter'.setup()
-- require 'nvim-treesitter.highlight'
-- local hlmap = vim.treesitter.TSHighlighter.hl_map

-- hlmap.error = nil

-- AUTOPAIRS

require('nvim-autopairs').setup({
    disable_filetype = {'TelescopePrompt'}
})

require('nvim-autopairs.completion.cmp').setup({
    map_cr = true, --  map <CR> on insert mode
    map_complete = true, -- it will auto insert `(` (map_char) after select function or method item
    auto_select = true, -- automatically select the first item
    insert = false, -- use insert confirm behavior instead of replace
    map_char = {
        -- modifies the function or method delimiter by filetypes
        all = '(',
        tex = '{'
    }
})

-- AUTOTAG

-- require('nvim-ts-autotag').setup()

-- NEORG

-- require('neorg').setup {
--     -- Tell Neorg what modules to load
--     load = {
--         ['core.defaults'] = {}, -- Load all the default modules
--         ['core.norg.concealer'] = {}, -- Allows for use of icons
--         ['core.keybinds'] = {
--             -- Configure core.keybinds
--             config = {
--                 default_keybinds = true, -- Generate the default keybinds
--                 neorg_leader = '<Leader>o' -- This is the default if unspecified
--             }
--         },
--         ['core.norg.dirman'] = {
--             -- Manage your directories with Neorg
--             config = {
--                 workspaces = {
--                     my_workspace = '~/neorg'
--                 }
--             }
--         },
--         ['core.norg.completion'] = {
--             config = {
--                 engine = 'nvim-cmp'
--             }
--         }
--     }
-- }

-- REST NVIM

require('rest-nvim').setup({
    -- Open request results in a horizontal split
    result_split_horizontal = false,
    -- Skip SSL verification, useful for unknown certificates
    skip_ssl_verification = false,
    -- Highlight request on run
    highlight = {
        enabled = true,
        timeout = 250
    },
    -- Jump to request line on run
    jump_to_request = false
})

-- NVIM-TREE

require'nvim-tree'.setup {
    -- disables netrw completely
    disable_netrw = true,
    -- hijack netrw window on startup
    hijack_netrw = true,
    -- open the tree when running this setup function
    open_on_setup = false,
    -- will not open on setup if the filetype is in this list
    ignore_ft_on_setup = {'startify'},
    -- closes neovim automatically when the tree is the last **WINDOW** in the view
    auto_close = true,
    -- opens the tree when changing/opening a new tab if the tree wasn't previously opened
    open_on_tab = true,
    -- hijack the cursor in the tree to put it at the start of the filename
    hijack_cursor = false,
    -- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
    update_cwd = false,
    -- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
    update_focused_file = {
        -- enables the feature
        enable = false,
        -- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
        -- only relevant when `update_focused_file.enable` is true
        update_cwd = false,
        -- list of buffer names / filetypes that will not update the cwd if the file isn't found under the current root directory
        -- only relevant when `update_focused_file.update_cwd` is true and `update_focused_file.enable` is true
        ignore_list = {}
    },
    -- configuration options for the system open command (`s` in the tree by default)
    system_open = {
        -- the command to run this, leaving nil should work in most cases
        cmd = nil,
        -- the command arguments as a list
        args = {}
    }
}

local prettierd = function()
    return {
        exe = 'prettierd',
        args = {vim.api.nvim_buf_get_name(0)},
        -- args = {
        --     '--stdin-filepath',
        --     vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), '--single-quote',
        --     '--tab-width', 4
        -- },
        stdin = true
    }
end

local prettier = function()
    return {
        exe = 'prettier',
        -- args = {vim.api.nvim_buf_get_name(0)},
        args = {
            '--stdin-filepath',
            vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), '--single-quote',
            '--print-width', 120, '--tab-width', 4, '--arrow-parens', 'avoid'
        },
        stdin = true
    }
end

local luafmt = function()
    return {
        exe = 'luafmt',
        args = {'--indent-count', 4, '--stdin'},
        stdin = true
    }
end

local luaformat = function()
    return {
        exe = 'lua-format',
        args = {
            vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
            '--double-quote-to-single-quote', '--column-limit=80'
        },
        stdin = true
    }
end

local rustfmt = function()
    return {
        exe = 'rustfmt',
        args = {'--emit=stdout'},
        stdin = true
    }
end

require('formatter').setup({
    logging = true,
    filetype = {
        javascript = {prettier},
        typescript = {prettier},
        typescriptreact = {prettier},
        graphql = {prettier},
        html = {prettier},
        css = {prettier},
        json = {prettier},
        lua = {luaformat},
        rust = {rustfmt}
    }
})
