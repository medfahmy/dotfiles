local M = {}

function bind(op, outer_opts)
    outer_opts = outer_opts or { noremap = true, silent = true }

    return function(lhs, rhs, opts)
        opts = vim.tbl_extend("force", outer_opts, opts or {})
        vim.keymap.set(op, lhs, rhs, opts)
    end
end

M.map = bind("", { noremap = false })
M.nmap = bind("n", { noremap = false })
M.noremap = bind("", { noremap = false })
M.nnoremap = bind("n")
M.vnoremap = bind("v")
M.xnoremap = bind("x")
M.inoremap = bind("i")
M.tnoremap = bind("t")
M.cnoremap = bind("c")

return M
