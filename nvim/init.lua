require("opts")
require("plug")

vim.cmd([[
    set guioptions-=e
    set guioptions+=!
    set sessionoptions+=tabpages,globals
    set shellcmdflag-=ic
]])

P = function(v)
    print(vim.inspect(v))
    return v
end

