local ok, neogit = pcall(require, "neogit")
if not ok then return end

neogit.setup()

local nnoremap = require("keymap").nnoremap
nnoremap("<space>g", ':lua require("neogit").open({ kind = "vsplit" })<cr>')
