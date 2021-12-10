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

require'tabline'.setup {
    -- Defaults configuration options
    enable = true,
    options = {
        -- If lualine is installed tabline will use separators configured in lualine by default.
        -- These options can be used to override those settings.
        section_separators = {'',''},
        component_separators = {'',''},
        max_bufferline_percent = 66, -- set to nil by default, and it uses vim.o.columns * 2/3
        show_tabs_always = false, -- this shows tabs only when there are more than one tab or if the first tab is named
        show_devicons = true, -- this shows devicons in buffer section
        show_bufnr = false, -- this appends [bufnr] to buffer section,
        show_filename_only = false, -- shows base filename only instead of relative path in filename
    }
}

vim.cmd[[
set guioptions-=e " Use showtabline in gui vim
set sessionoptions+=tabpages,globals " store tabpages and globals in session
]]

require'lualine'.setup {
    options = {
        icons_enabled = true,
        theme = 'iceberg_dark',
        section_separators = {'█▎','█▎'},
        component_separators = {'▎','▎'},
        disabled_filetypes = {},
        always_divide_middle = true,
    },
    sections = {
        lualine_a = {'filename'},
        lualine_b = { 
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
        },
        lualine_c = {{'diagnostics', sources={'nvim_lsp'}}},
        lualine_x = {'branch', 'diff'},
        lualine_y = {'filetype'},
        lualine_z = {'location'}
    },
}
