vim.cmd([[
    :hi      NvimTreeExecFile    guifg=#ffa0a0
    :hi      NvimTreeSpecialFile guifg=#ff80ff gui=underline
    :hi      NvimTreeSymlink     guifg=Yellow  gui=italic
    :hi link NvimTreeImageFile   Title
]])

return {
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("kanagawa").setup({
                transparent = true,
                theme = "dark",
                background = {
                    dark = "wave",
                    light = "lotus",
                }
            })
            -- load the colorscheme here
            vim.cmd("colorscheme kanagawa")
        end,
    },

    { "airblade/vim-gitgutter" },
    { 'danilamihailov/beacon.nvim' },

    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require('lualine').setup {
                options = {
                    theme = require("lualineThemes.transparent").theme(),
                }
            }
        end,
    },

    {
        "nvim-tree/nvim-tree.lua",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            local function my_on_attach(bufnr)
                local api = require "nvim-tree.api"

                local function opts(desc)
                    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
                end

                -- default mappings
                api.config.mappings.default_on_attach(bufnr)

                vim.keymap.del("n", "<C-e>", { buffer = bufnr })
                vim.keymap.set("n", "<C-e>", vim.cmd.NvimTreeToggle)
            end

            require("nvim-tree").setup {
                on_attach = my_on_attach,
            }
        end,
    },
}
