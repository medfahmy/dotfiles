local colors = {
    bg = "#202328",
    fg = "#bbc2cf",
    white = "#ffffff",
    yellow = "#fabd2f",
    cyan = "#008080",
    darkblue = "#081633",
    green = "#b8bb26",
    orange = "#fe8019",
    violet = "#d3869b",
    magenta = "#c678dd",
    blue = "#51afef",
    red = "#fb4934",
    darkred = "#cc241d",
    brightgreen = "#00ff00",
    brightyellow = "#ffff00",
    brightred = "#ff0000",
}

require("lualine").setup({
    options = {
        icons_enabled = true,
        theme = "iceberg_dark",
        section_separators = { "█▎", "█▎" },
        component_separators = { "▎", "▎" },
        disabled_filetypes = {},
        always_divide_middle = true,
        disabled_filetypes = { -- Filetypes to disable lualine for.
            statusline = { "NvimTree" },
            winbar = { "NvimTree" },
        },
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
                -- icon = " lsp:",
                -- icon = " lsp:",
                -- color = {
                --     fg = "#ffffff",
                --     gui = "bold",
                -- },
            },
        },
        lualine_z = { "branch" },
        lualine_b = {{ "filename", path = 1 }},
    },
})
