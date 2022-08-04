local ls = require("luasnip")
local types = require("luasnip.util.types")

local rfc = nil

ls.snippets = {
    all = {
        ls.parser.parse_snippet("expand", "-- this is what was expanded!"),
    },
    typescriptreact = {

    }
}

expand

ls.config.set_config({
    history = true,
    updateevents = "TextChanged,TextChangedI",
    enable_autosnippets = true,
    ext_opts = {
        [types.choiceNode] = {
            active = {
                virt_text = { { "<-", "Error" } },
            },
        },
    },
})

vim.keymap.set({ "i", "s" }, "<c-k>", function()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end, { noremap = true, silent = true, expr = true })

vim.keymap.set({ "i", "s" }, "<c-k>", function()
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end, { noremap = true, silent = true })

--[[
" press <Tab> to expand or jump in a snippet. These can also be mapped separately
" via <Plug>luasnip-expand-snippet and <Plug>luasnip-jump-next.
imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
" -1 for jumping backwards.
inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>

snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>
]]
--

vim.keymap.set({ "i", "s" }, "<c-l>", function()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end, { noremap = true, silent = true })

--[[
" For changing choices in choiceNodes (not strictly necessary for a basic setup).
imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
]]
--
