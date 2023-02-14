require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "c",
        "lua",
        "rust",
        "typescript",
        "javascript",
        "python",
        "sql",
        "toml",
        "json",
        "html",
        "css",
        "vim",
        "wgsl",
    },
    sync_install = false,
    auto_install = true,
    ignore_install = {},
    highlight = {
        enable = true,
        -- disable = { "rust" },
        additional_vim_regex_highlighting = false,
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

require("nvim-treesitter.configs").setup({
    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = 1000,
        colors = {
            "#c594c5",
            "#fac863",
            "#5fafd7",
            "#99c794",
            "#f99157",
            "#5fafd7",
            "#c594c5",
        },
    },
})
