require('remap')

vim.opt.termguicolors = true

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.termguicolors = true

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.scrolloff = 8

vim.opt.colorcolumn = "80"

require("lazyconf")
require("lsp_config")

vim.api.nvim_set_hl(0, 'DiagnosticNumHLError', { link = 'DiagnosticError' })
vim.api.nvim_set_hl(0, 'DiagnosticNumHLWarn', { link = 'DiagnosticWarn' })
vim.api.nvim_set_hl(0, 'DiagnosticNumHLInfo', { link = 'DiagnosticInfo' })
vim.api.nvim_set_hl(0, 'DiagnosticNumHLHint', { link = 'DiagnosticHint' })

vim.diagnostic.config({
    signs = {
        numhl = {
            [vim.diagnostic.severity.ERROR] = 'DiagnosticNumHLError',
            [vim.diagnostic.severity.WARN]  = 'DiagnosticNumHLWarn',
            [vim.diagnostic.severity.INFO]  = 'DiagnosticNumHLInfo',
            [vim.diagnostic.severity.HINT]  = 'DiagnosticNumHLHint',
        }
    }
})

-- Diagnostic signs remove bg
vim.api.nvim_set_hl(0, 'DiagnosticSignError', { link = 'DiagnosticError', bg = 'NONE' })
vim.api.nvim_set_hl(0, 'DiagnosticSignWarn', { link = 'DiagnosticWarn', bg = 'NONE' })
vim.api.nvim_set_hl(0, 'DiagnosticSignInfo', { link = 'DiagnosticInfo', bg = 'NONE' })
vim.api.nvim_set_hl(0, 'DiagnosticSignHint', { link = 'DiagnosticHint', bg = 'NONE' })

-- Wrap for specific filetypes
vim.api.nvim_create_autocmd('BufEnter', {
    pattern = { '*.org' },
    group = group,
    command = 'setlocal wrap'
})
