require("telescope").setup({
    defaults = {
        prompt_prefix = " >> ",
        mappings = {
            i = {
              ["<esc>"] = require('telescope.actions').close,
            },
        },
        file_ignore_patterns = {
            "node_modules/",
            "dist/",
            ".git/",
            "__pycache__",
            "target/",
            "venv",
            ".next",
        },
        -- file_sorter = require("telescope.sorters").get_fzy_sorter,
        color_devicons = true,

        -- file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        -- grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        -- qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
    },
    pickers = {
        buffers = {
            sort_last_used = true,
        },
        find_files = {
            hidden = true,
            sort_last_used = true,
        },
        file_browser = {
            sort_last_used = true,
            hidden = true,
        },
        live_grep = {
            sort_last_used = true,
            hidden = true,
        },
    },
    extensions = {
        frecency = {
            default_workspace = "CWD",
        },
        fzy_native = {
            override_generic_sorter = true,
            override_file_sorter = true,
        },
    },
})

local _, keymap = pcall(require, "keymap")
local ok, telescope = pcall(require, "telescope.builtin")

if not ok then return end

local nnoremap = keymap.nnoremap

nnoremap("<space>f", telescope.find_files)
nnoremap("<space>b", telescope.buffers)
nnoremap("<space>tr", telescope.resume)
nnoremap("<space>tt", "<cmd>Telescope<cr>")
nnoremap("<space>tg", telescope.live_grep)
nnoremap("<space>tf", telescope.git_files)
nnoremap("<space>tc", telescope.colorscheme)
nnoremap("<space>ts", telescope.lsp_dynamic_workspace_symbols)
nnoremap("<space>tk", telescope.keymaps)
nnoremap("<space>th", telescope.help_tags)
