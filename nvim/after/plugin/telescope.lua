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
