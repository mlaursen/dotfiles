local map = vim.keymap.set

vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

if vim.fn.executable("ag") then
  vim.g.ackprg = "ag --vimgrep"

  map("v", "<leader>g", "y:Ag<space><C-R>\"<cr>")
  map("n", "<leader>g", ":Ag<space>")
  map("n", "<F9>", ":cp<cr>")
  map("n", "<F10>", ":cn<cr>")
end

map("n", "<leader>sf", ":setlocal tw=80<cr>")