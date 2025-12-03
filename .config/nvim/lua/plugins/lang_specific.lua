return {
    {
        'leoluz/nvim-dap-go',
        dependencies = {
            'mfussenegger/nvim-dap'
        },
        config = function()
            require('dap-go').setup()
            local dap = require('dap')
            vim.keymap.set('n', '<leader>da', dap.repl.open)
            vim.keymap.set('n', '<leader>dj', dap.step_over)
            vim.keymap.set('n', '<leader>dl', dap.step_into)
            vim.keymap.set('n', '<leader>bp', dap.toggle_breakpoint)
        end
    },
    {
        "yanskun/gotests.nvim",
        ft = "go",
        config = function()
            require("gotests").setup()
            vim.keymap.set('n', '<leader>gt', "<Cmd>GoTests<CR>")
        end,
    },
}
