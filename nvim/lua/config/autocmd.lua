local autocmd = vim.api.nvim_create_autocmd

-- return to last edited location in file
autocmd("BufReadPost", {
  pattern = "*",
  command = "silent! normal! g`\"zv"
})

local open_edit_file = { "BufRead", "BufNewFile" }
autocmd(open_edit_file, {
  pattern = ".babelrc,.eslintrc",
  command = "set ft=jsonc",
})

-- Make it so any .env files are correctly styled. Normally only worked with .env
autocmd(open_edit_file, {
  pattern = "*",
  command = [[if expand('%t') =~ '\.env' | set filetype=sh | endif]],
})

-- update scss files for SassDoc comments
autocmd("FileType", {
  pattern = "scss",
  command = "set comments^=:///",
})