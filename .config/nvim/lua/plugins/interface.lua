vim.cmd([[
    :hi      NvimTreeExecFile    guifg=#ffa0a0
    :hi      NvimTreeSpecialFile guifg=#ff80ff gui=underline
    :hi      NvimTreeSymlink     guifg=Yellow  gui=italic
    :hi link NvimTreeImageFile   Title
]])

return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
        config = function()
            require("tokyonight").setup({
                -- use the night style
                style = "night",

                styles = {
                    -- Background styles. Can be "dark", "transparent" or "normal"
                    sidebars = "normal", -- style for sidebars, see below
                    floats = "normal",   -- style for floating windows
                },
            })
            vim.cmd [[ colorscheme tokyonight-night ]]
        end
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
                    theme = 'tokyonight-night'
                }
            }
        end,
    },
}
