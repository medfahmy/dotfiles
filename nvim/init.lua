require("opts")
require("plug")
-- require("statusline")

local augroup = vim.api.nvim_create_augroup
main_group = augroup("Main", {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightYank", {})

autocmd("TextYankPost", {
    group = yank_group,
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = 100,
        })
    end,
})

autocmd("BufWritePre", {
    group = main,
    pattern = "*",
    command = "%s/\\s\\+$//e",
})

autocmd("BufReadPost", {
    group = main,
    pattern = "*",
    command = [[if @% !~# '\.git[\/\\]COMMIT_EDITMSG$' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif]],
})

-- autocmd("BufEnter", {
--     group = main,
--     pattern = "*",
--     callback = function()
--         vim.diagnostic.disable()
--     end,
-- })

vim.cmd([[
    tnoremap <esc> <c-\><c-n>
    nnoremap <c-t> :vertical term<cr>
    set formatoptions-=cro
]])
