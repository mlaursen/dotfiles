local map = vim.keymap.set

vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

map("n", "<F9>", ":cp<cr>")
map("n", "<F10>", ":cn<cr>")
map("n", "<leader>sf", ":setlocal tw=80<cr>")