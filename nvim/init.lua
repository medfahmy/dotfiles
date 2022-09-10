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
            timeout = 200,
        })
    end,
})

autocmd("BufWritePre", {
    group = main,
    pattern = "*",
    command = "%s/\\s\\+$//e",
})
