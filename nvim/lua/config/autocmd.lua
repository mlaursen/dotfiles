local autocmd = vim.api.nvim_create_autocmd

-- return to last edited location in file
autocmd("BufReadPost", {
  pattern = "*",
  command = "silent! normal! g`\"zv"
})