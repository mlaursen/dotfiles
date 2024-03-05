vim.filetype.add({
  extension = {
    mdx = "markdown.mdx",
    tsx = "typescriptreact",
  },
  filename = {
    [".swcrc"] = "jsonc",
    [".babelrc"] = "jsonc",
    [".eslintrc"] = "jsonc",
  },
  pattern = {
    [".?env.?.*"] = "sh"
  },
})
