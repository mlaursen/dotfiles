-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- remove the save behavior
vim.keymap.del({ "i", "x", "n", "s" }, "<C-s>")

-- remove lazygit mappings and switch to vim-fugitive
vim.keymap.del("n", "<leader>gg")
vim.keymap.del("n", "<leader>gG")

-- have to set this here because I delete the normal keymaps
vim.keymap.set("n", "<leader>gg", "<cmd>Git<cr>")
