local del = vim.keymap.del
-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- remove the save behavior
del({ "i", "x", "n", "s" }, "<C-s>")

-- remove lazygit mappings that don't have another mapping for with vim-fugitive/fzf-lua
-- del("n", "<leader>gg")
del("n", "<leader>gG")
-- del("n", "<leader>gb")
-- del("n", "<leader>gB")
del("n", "<leader>gf")
-- del("n", "<leader>gl")
del("n", "<leader>gL")
