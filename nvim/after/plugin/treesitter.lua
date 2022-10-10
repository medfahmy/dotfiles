require("nvim-treesitter.configs").setup({
    ensure_installed = {"c", "lua", "rust", "typescript", "javascript", "python", "sql", "toml", "json"},
    auto_install = true,
    ignore_install = {},
    highlight = {
        enable = true,
        disable = { "toml" },
        additional_vim_regex_highlighting = true,
    },
    textobjects = {
        select = {
            enable = true,
        },
    },
    indent = {
        enable = true,
    },
    autotag = {
        enable = true,
        filetypes = {
            "html",
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "svelte",
        },
    },
})
