local opts = { noremap = true, silent = false }
vim.g.mapleader = " "
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("i", "<C-c>", "<Esc>")
vim.api.nvim_set_keymap("n", "<CR>", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
