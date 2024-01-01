local _, mark = pcall(require, "harpoon.mark")
local ok, ui = pcall(require, "harpoon.ui")

if not ok then
    return
end

local nnoremap = require("keymap").nnoremap

nnoremap("<space>m", mark.add_file)
nnoremap("<space>v", ui.toggle_quick_menu)
nnoremap("<tab>", ui.nav_next)
nnoremap("<s-tab>", ui.nav_prev)
