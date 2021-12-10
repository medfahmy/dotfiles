vim.cmd([[
    aug highlight_yank
      au!
      au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=200}
    aug END

    aug format_options
      au BufNewFile,BufRead,BufEnter * setlocal formatoptions-=ro
    aug END
]])
