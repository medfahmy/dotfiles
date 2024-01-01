vim.cmd("let g:neo_tree_remove_legacy_commands = 1")

require("neo-tree").setup({
    close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
    filesystem = {
        filtered_items = {
            visible = true,
        }
    },
    window = {
        position = "right",
    }
})

require("keymap").nnoremap("<space>n", "<cmd>Neotree toggle<cr>")
