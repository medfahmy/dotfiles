require("nvim-treesitter.configs").setup({
    -- ensure_installed = 'all', -- one of 'all', 'maintained' (parsers with maintainers), or a list of languages
    ensure_installed = {
        "python",
        "svelte",
        "c",
        "go",
        "rust",
        "ocaml",
        "haskell",
        "typescript",
        "javascript",
        "tsx",
        "http",
        "html",
        "css",
    },
    ignore_install = {}, -- List of parsers to ignore installing
    highlight = {
        enable = true,
        -- disable = {'tsx', 'typescript'}, -- list of language that will be disabled
        disable = {},
        -- disable = true,
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = true,
    },
    rainbow = {
        enable = true,
        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = nil, -- Do not enable for files with more than n lines, int
        -- colors = {}, -- table of hex strings
        -- termcolors = {} -- table of colour name strings
    },
    autotag = {
        enable = true,
        filetypes = {
            "javascript",
            "javascriptreact",
            "typescriptreact",
            "tsx",
            "svelte",
        },
    },
})
