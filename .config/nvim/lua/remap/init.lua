local opts = { noremap = true, silent = false }
vim.g.mapleader = " "
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("i", "<C-c>", "<Esc>")
vim.api.nvim_set_keymap("n", "<CR>", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>dv", "<Cmd>lua vim.diagnostic.open_float()<CR>", opts) -- Diag view
