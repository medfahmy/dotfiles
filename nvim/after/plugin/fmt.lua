local nnoremap = require("keymap").nnoremap
nnoremap("<space>=", "<cmd>Format<cr>")

local prettier = function()
    return {
        exe = "prettier",
        -- args = {vim.api.nvim_buf_get_name(0)},
        args = {
            "--stdin-filepath",
            vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
            "--print-width",
            160,
            "--tab-width",
            4,
            "--arrow-parens avoid",
            -- '--single-quote',
        },
        stdin = true,
    }
end

local pyfmt = function()
    return {
        exe = "python3 -m autopep8",
        args = {
            "--in-place --aggressive",
            vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
        },
        stdin = false,
    }
end

-- local luafmt = function()
--     return {
--         exe = 'luafmt',
--         args = {'--indent-count', 4, '--stdin'},
--         stdin = true
--     }
-- end

local util = require("formatter.util")

local stylua = function()
    return {
        exe = "stylua",
        args = {
            "--search-parent-directories",
            "--indent-type Spaces",
            "--column-width 80",
            "--stdin-filepath",
            util.escape_path(util.get_current_buffer_file_path()),
            "--",
            "-",
        },
        stdin = true,
    }
end

local rustfmt = function()
    return {
        exe = "rustfmt",
        args = { "--emit=stdout" },
        stdin = true,
    }
end

local gofmt = function()
    return {
        exe = "gofmt",
        args = { "-w", util.escape_path(util.get_current_buffer_file_path()) },
    }
end

require("formatter").setup({
    logging = true,
    filetype = {
        javascript = { prettier },
        typescript = { prettier },
        typescriptreact = { prettier },
        svelte = { prettier },
        graphql = { prettier },
        html = { prettier },
        css = { prettier },
        json = { prettier },
        lua = { stylua },
        rust = { rustfmt },
        python = { pyfmt },
        go = { gofmt },
    },
})
