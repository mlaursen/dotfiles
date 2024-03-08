-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
local autocmd = vim.api.nvim_create_autocmd

-- return to last edited location in file
-- autocmd("BufReadPost", {
--   pattern = "*",
--   command = 'silent! normal! g`"zv',
-- })

-- update scss files for SassDoc comments
autocmd("FileType", {
  pattern = "scss",
  command = "set comments^=:///",
})

autocmd("FileType", {
  pattern = "lua",
  command = "set comments^=:---",
})
