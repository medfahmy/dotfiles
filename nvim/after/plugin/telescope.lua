require("telescope").setup({
    defaults = {
        prompt_prefix = " >> ",
        file_ignore_patterns = { "node_modules/", "dist/", ".git/", "bin/", "__pycache__", "target/", "venv" },
        file_sorter = require("telescope.sorters").get_fzy_sorter,
        color_devicons = true,

        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
    },

    pickers = {
        buffers = {
            -- theme = 'dropdown',
            sort_lastused = true,
            -- previewer = false
        },
        find_files = {
            -- theme = 'dropdown',
            hidden = true,
            -- previewer = false,
            sort_lastused = true,
        },
        file_browser = {
            -- theme = 'dropdown',
            sort_lastused = true,
            -- hidden = true,
            -- previewer = false
        },
        live_grep = {
            -- theme = 'dropdown',
            sort_lastused = true,
            hidden = true,
        },
    },
    extensions = {
        -- fzy_native = {
        --   ovveride_generic_sorter = false,
        --   ovverride_file_sorter = true
        -- }
    },
})

local nnoremap = require("keymap").nnoremap
local telescope = require("telescope.builtin")

nnoremap("<space>f", telescope.find_files)
nnoremap("<space>b", telescope.buffers)
nnoremap("<space>tt", "<cmd>Telescope<cr>")
nnoremap("<space>tg", telescope.live_grep)
nnoremap("<space>tf", telescope.git_files)
nnoremap("<space>tc", telescope.colorscheme)
nnoremap("<space>ts", telescope.lsp_dynamic_workspace_symbols)
nnoremap("<space>tk", telescope.keymaps)
nnoremap("<space>th", telescope.help_tags)
