local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local main = augroup("Main", {})

autocmd("BufWritePre", {
    group = main,
    pattern = "*",
    command = "%s/\\s\\+$//e",
})

-- restore last location
autocmd("BufReadPost", {
    group = main,
    pattern = "*",
    command = [[if @% !~# '\.git[\/\\]COMMIT_EDITMSG$' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif]],
})

local hl_yank = augroup("HighlightYank", {})

autocmd("TextYankPost", {
    group = hl_yank,
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = 100,
        })
    end,
})

local cursorlineopt = augroup("CursorLine", { clear = true })

-- hide cursorline in insert mode
autocmd({ "InsertEnter", "WinLeave" }, {
    pattern = "*",
    callback = function()
        vim.opt.cursorlineopt = "number"
    end,
    group = cursorline,
})

autocmd({ "InsertLeave", "WinEnter" }, {
    pattern = "*",
    callback = function()
        vim.opt.cursorlineopt = "both"
    end,
    group = cursorline,
})

local hl_incsearch = augroup("HighlightIncSearch", {})

--     callback = function()
--         vim.opt.hlsearch = true
--     end,
-- })
--
-- autocmd("CmdlineLeave /", {
--     callback = function()
--         vim.opt.hlsearch = false
--     end,
-- })

-- autocmd("BufEnter", {
--     group = main,
--     pattern = "*",
--     callback = function()
--     end,
-- })

autocmd("BufEnter", {
    pattern = "*",
    callback = function()
        if vim.bo.ft ~= "terminal" then
            vim.opt.statusline = "%<%f %h%m%r%=%-14.(%l, %c%V%) %P"
        else
            vim.opt.statusline = "%#normal# "
        end
        -- vim.diagnostic.disable()
    end,
})
