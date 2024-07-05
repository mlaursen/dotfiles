vim.filetype.add({
  extension = {
    mdx = "markdown.mdx",
  },
  filename = {
    [".swcrc"] = "jsonc",
    [".babelrc"] = "jsonc",
    [".eslintrc"] = "jsonc",
    ["*.snippets"] = "snippets",
  },
})
