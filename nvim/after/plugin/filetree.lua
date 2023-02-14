vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

require("neo-tree").setup({
    filesystem = {
        filtered_items = {
            visible = true,
        }
    }
})

local nnoremap = require("keymap").nnoremap

nnoremap("<space>n", "<cmd>Neotree toggle<cr>")
