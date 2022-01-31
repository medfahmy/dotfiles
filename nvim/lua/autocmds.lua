vim.cmd([[
    aug highlight_yank
      au!
      au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=200}
    aug END

    aug format_options
      au BufNewFile,BufRead,BufEnter * setlocal formatoptions-=ro
    aug END

    aug run
        au!

        au FileType rust nnoremap <buffer> <leader>r <cmd>sp<cr> <cmd>term cargo run<cr> 
    aug END

]])

-- <cmd>startinsert<cr>
