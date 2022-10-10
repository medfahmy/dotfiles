local neogit = require("neogit")

neogit.setup()

local nnoremap = require("keymap").nnoremap
nnoremap("<space>g", ':lua require("neogit").open({ kind = "vsplit" })<cr>')
