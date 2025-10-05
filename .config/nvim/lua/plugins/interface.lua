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
                on_colors = function(colors)
                    colors.bg = '#181818'
                    colors.bg_dark = "#151515"
                    colors.bg_dark1 = "#0d0d0d"
                    colors.bg_float = colors.bg
                    colors.bg_highlight = "#282828"
                    colors.bg_popup = colors.bg
                    colors.bg_search = "#3d59a1"
                    colors.bg_sidebar = colors.bg
                    colors.bg_statusline = colors.bg
                    colors.bg_visual = colors.bg_highlight
                end,

                on_highlights = function(highlights, colors)
                    highlights.ColorColumn.bg = "#171717"
                    highlights.TabLine = { bg = "#1f1f1f", fg = colors.fg }
                    highlights.TabLineSel = { bg = colors.red, fg = "#000000" }
                end,

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
            require('lualine_config.evil_lualine')
        end,
    },
}
