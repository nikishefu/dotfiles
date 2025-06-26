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
    { 'xiyaowong/transparent.nvim' },

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
}
