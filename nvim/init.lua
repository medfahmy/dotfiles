vim.cmd('syntax enable')
vim.cmd('filetype plugin indent on')

require("opts")
require("keymaps")
require("plugins")
require("colors")
require("dev")


-- vim.cmd("hi Normal guibg=none")

local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = "*",
})

local hl_groups = vim.api.nvim_get_hl(0, {})

for key, hl_group in pairs(hl_groups) do
  if hl_group.italic then
    vim.api.nvim_set_hl(0, key, vim.tbl_extend("force", hl_group, {italic = false}))
  end
end
