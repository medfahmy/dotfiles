local prettier = function()
  return {
    exe = 'prettier',
    -- args = {vim.api.nvim_buf_get_name(0)},
    args = {
      '--stdin-filepath', vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
      '--single-quote', '--print-width', 80, '--tab-width', 4, '--arrow-parens',
      'avoid'
    },
    stdin = true
  }
end

local pyfmt = function()
    return {
        exe = "python3 -m autopep8",
        args = {
            "--in-place --aggressive --aggressive",
            vim.fn.fnameescape(vim.api.nvim_buf_get_name(0))
        },
        stdin = false
    }
end

-- local luafmt = function()
--     return {
--         exe = 'luafmt',
--         args = {'--indent-count', 4, '--stdin'},
--         stdin = true
--     }
-- end

local luaformat = function()
  return {
    exe = 'lua-format',
    args = {
      vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
      '--double-quote-to-single-quote', '--column-limit=80', '--indent-width=2'
    },
    stdin = true
  }
end

local rustfmt = function()
    return {
        exe = 'rustfmt',
        args = {'--emit=stdout'},
        stdin = true
    }
end

require('formatter').setup({
  logging = true,
  filetype = {
    javascript = {prettier},
    typescript = {prettier},
    typescriptreact = {prettier},
    graphql = {prettier},
    html = {prettier},
    css = {prettier},
    json = {prettier},
    lua = {luaformat},
    rust = {rustfmt},
    python = {pyfmt}

  }
})

vim.cmd[[nnoremap <silent> <leader>gp :Format<CR>]]
