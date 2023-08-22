-- lazy
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        "X3eRo0/dired.nvim",
        dependencies = "MunifTanjim/nui.nvim",
        config = {
            path_separator = "/",
            show_banner = false,
            show_hidden = true,
            show_dot_dirs = true,
            show_colors = true,
        },
    },
    { "norcalli/nvim-colorizer.lua" },
    { "RRethy/nvim-base16" },
    { 'rose-pine/neovim', name = 'rose-pine' },
    { "mhartington/oceanic-next" },
    -- { "github/copilot.vim" },
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        config = function()
            -- require("nvim-tree").setup({
            --     disable_netrw = true,
            --     open_on_tab = true,
            --     hijack_cursor = true,
            --     view = {
            --         side = "right",
            --     },
            --     renderer = {
            --         indent_width = 4,
            --         indent_markers = {
            --             enable = true,
            --         },
            --         icons = {
            --             show = {
            --                 file = false,
            --                 folder = false,
            --                 folder_arrow = false,
            --                 git = false,
            --                 modified = false,
            --             },
            --             glyphs = {
            --                 default = "",
            --                 symlink = "",
            --                 bookmark = "",
            --                 modified = "",
            --                 folder = {
            --                     arrow_closed = "",
            --                     arrow_open = "",
            --                     default = "",
            --                     open = "",
            --                     empty = "",
            --                     empty_open = "",
            --                     symlink = "",
            --                     symlink_open = "",
            --                 },
            --                 git = {
            --                     unstaged = "",
            --                     staged = "",
            --                     unmerged = "",
            --                     renamed = "",
            --                     untracked = "",
            --                     deleted = "",
            --                     ignored = "",
            --                 },
            --             },
            --         },
            --     },
            --     diagnostics = {
            --         enable = true,
            --         icons = {
            --             hint = "",
            --             info = "",
            --             warning = "",
            --             error = "",
            --         },
            --     },
            --     modified = {
            --         enable = true,
            --     },
            -- })
            -- vim.keymap.set("n", "<space>n", vim.cmd.NvimTreeToggle, { silent = true })

			local setup, nvimtree = pcall(require, "nvim-tree")
			if not setup then return end
            vim.keymap.set("n", "-", vim.cmd.NvimTreeToggle, { silent = true })



			-- local keymap = vim.keymap -- for conciseness
			-- keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>") -- toggle file explorer

			-- vim.opt.foldmethod = "expr"
			-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
			-- vim.opt.foldenable = false --                  " Disable folding at startup.

			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1

			vim.opt.termguicolors = true

			local HEIGHT_RATIO = 0.8 -- You can change this
			local WIDTH_RATIO = 0.5  -- You can change this too

			nvimtree.setup({
				disable_netrw = true,
				hijack_netrw = true,
				respect_buf_cwd = true,
				sync_root_with_cwd = true,
				view = {
					relativenumber = true,
					float = {
						enable = true,
						open_win_config = function()
							local screen_w = vim.opt.columns:get()
							local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
							local window_w = screen_w * WIDTH_RATIO
							local window_h = screen_h * HEIGHT_RATIO
							local window_w_int = math.floor(window_w)
							local window_h_int = math.floor(window_h)
							local center_x = (screen_w - window_w) / 2
							local center_y = ((vim.opt.lines:get() - window_h) / 2)
							- vim.opt.cmdheight:get()
							return {
								border = "rounded",
								relative = "editor",
								row = center_y,
								col = center_x,
								width = window_w_int,
								height = window_h_int,
							}
						end,
					},
					width = function()
						return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
					end,
				},
                renderer = {
                    indent_width = 4,
                    indent_markers = {
                        enable = true,
                    },
                    icons = {
                        show = {
                            file = false,
                            folder = false,
                            folder_arrow = false,
                            git = false,
                            modified = false,
                        },
                        glyphs = {
                            default = "",
                            symlink = "",
                            bookmark = "",
                            modified = "",
                            folder = {
                                arrow_closed = "",
                                arrow_open = "",
                                default = "",
                                open = "",
                                empty = "",
                                empty_open = "",
                                symlink = "",
                                symlink_open = "",
                            },
                            git = {
                                unstaged = "",
                                staged = "",
                                unmerged = "",
                                renamed = "",
                                untracked = "",
                                deleted = "",
                                ignored = "",
                            },
                        },
                    },
                },
				-- filters = {
				--   custom = { "^.git$" },
				-- },
				-- renderer = {
				--   indent_width = 1,
				-- },
			})
        end,
    },
    {
        "TimUntersberger/neogit",
        dependencies = { 
            "nvim-lua/plenary.nvim",
        },
        config = function()
            require("neogit").setup({
                disable_builtin_notifications = true,
            })
            vim.keymap.set("n", "<space>g", vim.cmd.Neogit, { silent = true, desc = "neogit" })
        end,
    },
    {
        "mbbill/undotree",
        config = function()
            vim.keymap.set("n", "<space>u", vim.cmd.UndotreeToggle, { silent = true, desc = "undotree" })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            { "j-hui/fidget.nvim", opts = {} },
            "folke/neodev.nvim",
        },
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip"
        },
    },
    { "folke/which-key.nvim", opts = {} },
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            signs = {
                add = { text = "+" },
                change = { text = "~" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
            },
        },
    },
    {
        "nvim-lualine/lualine.nvim",
        opts = {
            options = {
                icons_enabled = false,
                -- theme = "iceberg_dark",
                section_separators = { "█▎", "█▎" },
                component_separators = { "▎", "▎" },
                disabled_filetypes = {},
                always_divide_middle = true,
            },
            sections = {
                lualine_a = { "mode" },
                lualine_c = { "diff" },
                lualine_x = {
                    { "diagnostics", sources = { "nvim_diagnostic" } },
                },
                lualine_y = {
                    {
                        function()
                            local msg = ""
                            local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
                            local clients = vim.lsp.get_active_clients()
                            if next(clients) == nil then
                                return msg
                            end
                            for _, client in ipairs(clients) do
                                local filetypes = client.config.filetypes
                                if
                                    filetypes
                                    and vim.fn.index(filetypes, buf_ft) ~= -1
                                then
                                    msg = msg .. " " .. client.name
                                end
                            end
                            return msg
                        end,
                    },
                },
                lualine_z = { "branch" },
                lualine_b = {{ "filename", path = 1 }},
            },
        },
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        opts = {
            show_current_context = true,
            show_current_context_start = false,
            show_current_context_start_on_current_line = false,
            show_end_of_line = true,
        },
    },
    { "rmagatti/auto-session", opts = { log_level = "error" } },
    { "numToStr/Comment.nvim", opts = {} },
    {
        "nvim-telescope/telescope.nvim",
        version = "*",
        dependencies = { "nvim-lua/plenary.nvim" }
    },
    {
        "ThePrimeagen/harpoon",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            vim.keymap.set("n", "<space>l", require("harpoon.ui").toggle_quick_menu, { silent = true, desc = "list harpoon marks" })
            vim.keymap.set("n", "<space>m", require("harpoon.mark").add_file, { silent = true, desc = "add harpoon mark" })
            vim.keymap.set("n", "<space>b", require("harpoon.ui").nav_next, { silent = true, desc = "switch harpoon file" })
            -- vim.keymap.set("n", "<space>,", function() require("harpoon.ui").nav_file(1) end, { silent = true, desc = "nav next harpoon" })
            -- vim.keymap.set("n", "<space>.", function() require("harpoon.ui").nav_prev(2) end, { silent = true, desc = "nav prev harpoon" })
            -- vim.keymap.set("n", "<space>/", function() require("harpoon.ui").nav_prev(3) end, { silent = true, desc = "nav prev harpoon" })
        end,
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
            return vim.fn.executable "make" == 1
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            pcall(require("nvim-treesitter.install").update { with_sync = true })
        end,
    },
}, {})


-- options
local o = vim.o

o.showmode = false
o.swapfile = false
o.backup = false
o.undodir = os.getenv("HOME") .. "/.vim/undodir"
o.undofile = true
o.hlsearch = false
o.number = true
o.mouse = "a"
o.breakindent = true
o.undofile = true
o.ignorecase = true
o.smartcase = true
o.signcolumn = "yes:2"
o.updatetime = 250
o.timeout = true
o.timeoutlen = 300
o.completeopt = "menuone,noselect"
o.termguicolors = true
o.guicursor = "a:block"
o.cursorline = true
o.tabstop = 4
o.shiftwidth = 4
o.softtabstop = 4
o.expandtab = false
o.laststatus = 3
o.scrolloff = 8
o.list = false
o.listchars = "eol:↴"
o.fillchars = "eob: "
o.formatoptions = ""

-- keymaps
vim.keymap.set({ "n", "v" }, "<space>", "<nop>", { silent = true })
vim.keymap.set({ "n", "v" }, "q:", "<nop>", { silent = true })
vim.keymap.set({ "n", "v" }, "Q", "<nop>", { silent = true })

vim.keymap.set("n", "<c-w>", "<c-w>w", { silent = true, desc = "toggle window" })

vim.keymap.set({ "n", "v" }, "<space>x", "<cmd>bd<cr>", { silent = true })
-- vim.cmd([[tnoremap <c-[><c-[> <c-\><c-n>]])
vim.keymap.set("t", "<c-[><c-[>", "<c-\\><c-n>")

vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ "n", "v" }, "<space>y", '"+y', { silent = true })
vim.keymap.set({ "n", "v" }, "<space>Y", '"+y$', { silent = true })
vim.keymap.set({ "n", "v" }, "<space>p", '"+p', { silent = true })
vim.keymap.set({ "n", "v" }, "<space>P", '"+P', { silent = true })

-- moving text
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })

-- indenting selection while staying in visual mode
vim.keymap.set("v", "<", "<gv", { silent = true })
vim.keymap.set("v", ">", ">gv", { silent = true })

-- keeping it centered
vim.keymap.set("n", "n", "nzzzv", { silent = true })
vim.keymap.set("n", "N", "Nzzzv", { silent = true })
vim.keymap.set("n", "J", "mzJ`z", { silent = true })
vim.keymap.set("n", "<c-d>", "<c-d>zz", { silent = true })
vim.keymap.set("n", "<c-u>", "<c-u>zz", { silent = true })

-- undo break points
vim.keymap.set("i", ",", ",<c-g>u", { silent = true })
vim.keymap.set("i", ".", ".<c-g>u", { silent = true })
vim.keymap.set("i", "!", "!<c-g>u", { silent = true })
vim.keymap.set("i", "?", "?<c-g>u", { silent = true })
vim.keymap.set("i", "(", "(<c-g>u", { silent = true })
vim.keymap.set("i", ")", ")<c-g>u", { silent = true })
vim.keymap.set("i", "{", "{<c-g>u", { silent = true })
vim.keymap.set("i", "}", "}<c-g>u", { silent = true })
vim.keymap.set("i", "[", "[<c-g>u", { silent = true })
vim.keymap.set("i", "]", "]<c-g>u", { silent = true })
vim.keymap.set("i", "<", "<<c-g>u", { silent = true })
vim.keymap.set("i", ">", "><c-g>u", { silent = true })

-- jumplist mutations
vim.keymap.set("n", "k", '(v:count > 5 ? "m\'" . v:count : "") . \'k\'', { expr = true }, { silent = true })
vim.keymap.set("n", "j", '(v:count > 5 ? "m\'" . v:count : "") . \'j\'', { expr = true }, { silent = true })

-- wrapping visual selection
vim.keymap.set("v", '<space>"', '<esc>`>a"<esc>`<i"<esc>', { silent = true })
vim.keymap.set("v", "<space>(", "<esc>`>a)<esc>`<i(<esc>", { silent = true })
vim.keymap.set("v", "<space>[", "<esc>`>a]<esc>`<i[<esc>", { silent = true })
vim.keymap.set("v", "<space>'", "<esc>`>a'<esc>`<i'<esc>", { silent = true })
vim.keymap.set("v", "<space>{", "<esc>`>a}<esc>`<i{<esc>", { silent = true })

-- dont mutate jump list
vim.keymap.set("n", "{", ":keepjumps normal! {<cr>", { silent = true })
vim.keymap.set("n", "}", ":keepjumps normal! }<cr>", { silent = true })

local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = "*",
})

require("telescope").setup({
    defaults = {
        file_ignore_patterns = {
            "node_modules/", ".git/", "__pycache__", "target", "venv",
        },
        mappings = {
            i = {
                ["<C-u>"] = false,
                ["<C-d>"] = false,
                ["<esc>"] = require("telescope.actions").close,
            },
        },
    },
    pickers = {
        find_files = {
            hidden = true,
        },
    },
})

pcall(require("telescope").load_extension, "fzf")

local telescope = require("telescope.builtin")

vim.keymap.set("n", "<space>f", telescope.find_files, { desc = "telescope files" })
-- vim.keymap.set("n", "<space>/", telescope.oldfiles, { desc = "find recently opened files" })
vim.keymap.set("n", "<space>tb", telescope.buffers, { desc = "find existing buffers" })

vim.keymap.set("n", "<space>th", telescope.help_tags, { desc = "telescope help" })
vim.keymap.set("n", "<space>tg", telescope.live_grep, { desc = "telescope grep" })
vim.keymap.set("n", "<space>td", telescope.diagnostics, { desc = "telescope diagnostics" })
vim.keymap.set("n", "<space>tk", telescope.keymaps, { desc = "telescope keymaps" })
vim.keymap.set("n", "<space>tc", telescope.colorscheme, { desc = "telescope colorschemes" })

require("nvim-treesitter.configs").setup {
    ensure_installed = { "go", "lua", "python", "rust", "tsx", "typescript", "help" },
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true },
}

-- lsp keymaps
vim.keymap.set("n", "<space>k", vim.diagnostic.goto_prev)
vim.keymap.set("n", "<space>j", vim.diagnostic.goto_next)
-- vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

local nmap = function(keys, func, desc)
    if desc then
        desc = "lsp: " .. desc
end
    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
end

nmap("<space>d", "<cmd>Dired<cr>", "dired")

nmap("<space>r", vim.lsp.buf.rename, "rename")
nmap("<space>ca", vim.lsp.buf.code_action, "code action")

nmap("gd", vim.lsp.buf.definition, "goto definition")
nmap("gr", require("telescope.builtin").lsp_references, "goto references")
nmap("gI", vim.lsp.buf.implementation, "goto implementation")
nmap("<leader>D", vim.lsp.buf.type_definition, "type definition")
-- nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "document symbols")
nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "workspace symbols")

nmap("<space>h", vim.lsp.buf.hover, "hover documentation")
nmap("<space>vh", vim.lsp.buf.signature_help, "hover signature Documentation")
nmap("<space>e", vim.diagnostic.open_float, "show error")

-- nmap("<space>ld", vim.lsp.buf.declaration, "goto declaration")
nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "workspace add folder")
nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "workspace remove folder")
nmap("<space>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, "workspace list folders")

nmap("gb", vim.lsp.buf.format, "format buffer")

-- lsp
local servers = {
    pyright = {},
    rust_analyzer = {},
    tsserver = {},
    gopls = {},
    svelte = {},
    tailwindcss = {},
}

local handlers = {
    ["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics,
        {
            virtual_text = true,
            underline = true,
        }
    ),
    ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "single",
    }),
    ["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help,
        {
            border = "single",
        }
    ),
}

vim.diagnostic.config {     
    float = { 
        border = "single",
    }, 
}

require("neodev").setup()

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

require("mason").setup()

local mason_lspconfig = require "mason-lspconfig"

mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
    function(server_name)
        require("lspconfig")[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
            handlers = handlers,
        }
    end,
}

local cmp = require "cmp"
local luasnip = require "luasnip"

luasnip.config.setup {}

cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert {
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete {},
        ["<CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
    },
}

-- colors
local colors = {
    bg = "none",
    black = "#191919",
    gray1 = "#333333",
    gray2 = "#999999",
    gray3 = "#c7c7c7",
    gray4 = "#d4d5d5",
    white = "#ffffff",
    green = "#99c794",
    -- cyan = "#5fafd7",
    cyan = "#6cc9f9",
    blue = "#54aeff",
    purple1 = "#8097fb",
    purple2 = "#c594c5",
    purple3 = "#8250df",
    yellow = "#fac863",
    red = "#ec5f67",
    orange = "#f99157",
}

require('base16-colorscheme').setup({
    base00 = colors.bg, base01 = colors.black, base02 = colors.gray1, base03 = colors.gray2,
    base04 = colors.gray4, base05 = colors.gray4, base06 = colors.purple1, base07 = colors.white,
    base08 = "#dddddd", base09 = colors.yellow, base0A = colors.cyan, base0B = colors.green,
    base0C = colors.cyan, base0D = colors.blue, base0E = colors.purple2, base0F = colors.gray4,
})

vim.cmd("hi CursorLine guibg=#333333")
vim.cmd("hi CursorLineNr guifg=#fac863 guibg=#333333")
vim.cmd("hi WhichKeyFloat guibg=#333333")
vim.cmd("hi Normal guibg=none")
vim.cmd("hi Visual guibg=#555555")
vim.cmd("hi NormalFloat guibg=#333333")
vim.cmd("hi LineNr guibg=none guifg=#555555")
vim.cmd("hi SignColumn guibg=none")
vim.cmd("hi DiagnosticError guifg=#ec5f67")
vim.cmd("hi DiagnosticWarn guifg=#f99157")
vim.cmd("hi DiagnosticHint guifg=#f99157")
vim.cmd("hi DiffDelete guifg=#ec5f67")
