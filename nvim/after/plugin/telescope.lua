require("telescope").setup({
    defaults = {
        prompt_prefix = " >> ",
        file_ignore_patterns = { "node_modules/", "dist/", ".git/", "__pycache__", "target/", "venv", ".next" },
        file_sorter = require("telescope.sorters").get_fzy_sorter,
        color_devicons = true,

        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
    },

    pickers = {
        buffers = {
            sort_lastused = true,
        },
        find_files = {
            hidden = true,
            sort_lastused = true,
        },
        file_browser = {
            sort_lastused = true,
        },
        live_grep = {
            sort_lastused = true,
            hidden = true,
        },
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
