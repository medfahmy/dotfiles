require('telescope').setup {
  defaults = {
    prompt_prefix = '>> ',
    file_ignore_patterns = {'node_modules/', 'dist/', '.git/', 'bin/', '__pycache__', 'lib'},
    file_sorter = require('telescope.sorters').get_fzy_sorter,
    color_devicons = true,
    -- file_previewer = require('telescope.previewers').vim_buffer_cat.new,
    -- grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new
  },
  pickers = {
    buffers = {
      theme = 'dropdown',
      sort_lastused = true
      -- previewer = false
    },
    find_files = {
      theme = 'dropdown',
      hidden = true,
      -- previewer = false,
      sort_lastused = true
    },
    file_browser = {
      theme = 'dropdown',
      sort_lastused = true
      -- hidden = true,
      -- previewer = false
    },
    live_grep = {
      theme = 'dropdown',
      sort_lastused = true,
      hidden = true
    }
  },
  extensions = {
    -- fzy_native = {
    --   ovveride_generic_sorter = false,
    --   ovverride_file_sorter = true
    -- }
  }
}

-- require'telescope'.load_extension('project')
-- require'telescope'.load_extension('fzy_native')


vim.cmd([[
nnoremap <leader>f <cmd>Telescope find_files<cr>
nnoremap <leader>b <cmd>Telescope buffers<cr>
nnoremap <leader>tb <cmd>Telescope file_browser<cr>
nnoremap <leader>cs <cmd>Telescope colorscheme<cr>
nnoremap <leader>tg <cmd>Telescope live_grep<cr>
nnoremap <leader>ts <cmd>Telescope lsp_dynamic_workspace_symbols<cr>
" nnoremap <leader>tp <cmd>Telescope project<cr>
" nnoremap <leader>tp <cmd>lua require'telescope'.extensions.project.project{ display_type = 'full'}<cr>
" nnoremap <leader><leader> <cmd>lua require'telescope'.extensions.frecency.frecency()<cr>
]])
