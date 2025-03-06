local set = vim.keymap.set
local del = vim.keymap.del
-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- remove the save behavior
del({ "i", "x", "n", "s" }, "<C-s>")

-- remove lazygit mappings that don't have another mapping for with vim-fugitive/fzf-lua
-- del("n", "<leader>gg")
-- del("n", "<leader>gG")
-- del("n", "<leader>gb")
-- del("n", "<leader>gB")
-- del("n", "<leader>gf")
-- del("n", "<leader>gl")
-- del("n", "<leader>gL")

-- I like `<C-j>` and `<C-k>` for jumping snippets instead
-- Tab is to move through menus
if vim.fn.has("nvim-0.11") == 0 then
  del("s", "<Tab>")
  del({ "i", "s" }, "<S-Tab>")
end

set({ "i", "s" }, "<C-j>", function()
  return vim.snippet.active({ direction = 1 }) and "<cmd>lua vim.snippet.jump(1)<cr>" or "<C-j>"
end, { expr = true, desc = "Jump Next" })
set({ "i", "s" }, "<C-k>", function()
  return vim.snippet.active({ direction = -1 }) and "<cmd>lua vim.snippet.jump(-1)<cr>" or "<C-j>"
end, { expr = true, desc = "Jump Previous" })
