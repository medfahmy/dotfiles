local colors = {
  bg = '#202328',
  fg = '#bbc2cf',
  white = '#ffffff',
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

require'stabilize'.setup()

require'lspinstall'.setup()
local servers = require'lspinstall'.installed_servers()
local lspconfig = require'lspconfig'
for _, server in pairs(servers) do
  lspconfig[server].setup {}
end

lspconfig.lua.setup{
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  }
}

-- require'neogit'.setup {}

require'lualine'.setup {
  options = {
    icons_enabled = true,
    padding = 1,
    theme = 'seoul256',
    section_separators = {'█▎'},
    component_separators = {'▎'},
    disabled_filetypes = {'help', 'netrw'}
  },
  sections = {
    lualine_a = {'mode'},
    lualine_y = {
      {
        'branch',
        -- icon = '',
        -- color = {
        --   fg = colors.violet,
        --   gui = 'bold'
        -- }
      },     },
    lualine_b = {
      {
        'filename',
        file_status = true,
        path = 1
      }
      -- {
      --     'filetype',
      --     colored = true
      -- },
      -- function()
      --   local f = require'nvim-treesitter'.statusline({
      --     indicator_size = 300,
      --     type_patterns = {"class", "function", "method",
      --       "interface", "type_spec", "table",
      --       "if_statement", "for_statement", "for_in_statement"}
      --    })
      --   local fun_name = string.format("%s", f) -- convert to string, it may be a empty ts node
      --   if fun_name == "vim.NIL" then
      --     return " "
      --   end
      --   return fun_name
      -- end
    },
    lualine_c = {
      {
        function()
          local msg = ''
          local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
          local clients = vim.lsp.get_active_clients()
          if next(clients) == nil then return msg end
          for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
              return client.name
            end
          end
          return msg
        end,
        icon = ' lsp:',
        color = {
          fg = '#ffffff',
          gui = 'bold'
        }
      },
      {
        'diagnostics',
        sources = {'nvim_lsp'},
        -- symbols = {error = '', warn = '', info = ''},
        -- symbols = {error = 'x', warn = '!', info = '*'},
        color_error = colors.red,
        color_warn = colors.orange,
        color_info = colors.green
      },
      color = {
        fg = colors.white
      }
    },
    -- lualine_y = {
    --     {
    --         'filetype',
    --         colored = true
    --     }
    -- },
    lualine_x = {
      {
        'diff',
        colored = true,
        -- diff_color = {
        --     added = colors.green,
        --     modified = colors.yellow,
        --     removed = colors.red,
        -- },
        -- symbols = {added = '+', modified = '~', removed = '-'}
      }
    },
    lualine_z = {'location'}
  },
  -- tabline = {
  --   lualine_a = { 'buffers' },
  -- }
}

require'bufferline'.setup {
  options = {
    modified_icon = '+',
    show_close_icon = false
  }
}

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
    -- ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    -- ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    -- ['<C-e>'] = cmp.mapping.close(),
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

vim.lsp.handlers['textDocument/publishDiagnostics'] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = true,
      update_in_insert = false,
      underline = true,
      signs = true
    })

local capabilities = require('cmp_nvim_lsp')
  .update_capabilities(vim.lsp.protocol.make_client_capabilities())

require'lspconfig'.tsserver.setup {
  capabilities = capabilities
}

-- require'lspconfig'.graphql.setup {
--     filetypes = {'graphql', 'graphqls'},
--     capabilities = capabilities
-- }
--
-- require'lspconfig'.hls.setup {
--     capabilities = capabilities
-- }
--
-- require'lspconfig'.vimls.setup {
--     capabilities = capabilities
-- }
--
-- require'lspconfig'.rust_analyzer.setup {
--     capabilities = capabilities
-- }

-- require'lspconfig'.gopls.setup{}

require'lspconfig'.cssls.setup {
  capabilities = capabilities
}

-- require'lspconfig'.html.setup {
--     capabilities = capabilities
-- }

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

require('telescope').setup {
  defaults = {
    prompt_prefix = '>> ',
    file_ignore_patterns = {'node_modules', 'dist', 'build', '.git'},
    file_sorter = require('telescope.sorters').get_fzy_sorter,
    color_devicons = true,
    file_previewer = require('telescope.previewers').vim_buffer_cat.new,
    grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new
  },
  pickers = {
    buffers = {
      -- theme = 'dropdown',
      sort_lastused = true
      -- previewer = false
    },
    find_files = {
      -- theme = 'dropdown',
      hidden = true,
      -- previewer = false,
      sort_lastused = true
    },
    file_browser = {
      -- theme = 'dropdown',
      sort_lastused = true
      -- hidden = true,
      -- previewer = false
    },
    live_grep = {
      -- theme = 'dropdown',
      sort_lastused = true,
      hidden = true
    }
  },
  extensions = {
    fzy_native = {
      ovveride_generic_sorter = false,
      ovverride_file_sorter = true
    }
  }
}

require'telescope'.load_extension('project')
require'telescope'.load_extension('fzy_native')

require('trouble').setup {
  icons = true
}

local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()
parser_configs.http = {
  install_info = {
    url = 'https://github.com/NTBBloodbath/tree-sitter-http',
    files = {'src/parser.c'},
    branch = 'main'
  }
}

require'nvim-treesitter.configs'.setup {
  -- ensure_installed = 'all', -- one of 'all', 'maintained' (parsers with maintainers), or a list of languages
  ensure_installed = {'typescript', 'javascript', 'tsx', 'lua', 'http'},
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
    filetypes = {'javascript', 'javascriptreact', 'typescriptreact', 'tsx'}
  }
}

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

-- local prettierd = function()
--     return {
--         exe = 'prettierd',
--         args = {vim.api.nvim_buf_get_name(0)},
--         -- args = {
--         --     '--stdin-filepath',
--         --     vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), '--single-quote',
--         --     '--tab-width', 4
--         -- },
--         stdin = true
--     }
-- end

local prettier = function()
  return {
    exe = 'prettier',
    -- args = {vim.api.nvim_buf_get_name(0)},
    args = {
      '--stdin-filepath', vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
      '--single-quote', '--print-width', 80, '--tab-width', 2, '--arrow-parens',
      'avoid'
    },
    stdin = true
  }
end

-- local luafmt = function()
--     return {
--         exe = 'luafmt',
--         args = {'--indent-count', 4, '--stdin'},
--         stdin = true
--     }
-- end

local luaformat = function()
  return {
    exe = 'lua-format',
    args = {
      vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
      '--double-quote-to-single-quote', '--column-limit=80', '--indent-width=2'
    },
    stdin = true
  }
end

-- local rustfmt = function()
--     return {
--         exe = 'rustfmt',
--         args = {'--emit=stdout'},
--         stdin = true
--     }
-- end

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
    lua = {luaformat}
    -- rust = {rustfmt}
  }
})

vim.api.nvim_set_keymap(
  'n',
  '<leader><leader>',
  '<Cmd>lua require(\'telescope\').extensions.frecency.frecency()<CR>',
  {
    noremap = true,
    silent = true
  }
)
