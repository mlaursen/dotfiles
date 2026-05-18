vim.filetype.add({
  extension = {
    mdx = "markdown.mdx",
    njk = "htmldjango",
    -- njk = "jinja.html",
    -- njk = "jinja",
  },
  filename = {
    [".swcrc"] = "jsonc",
    [".babelrc"] = "jsonc",
    [".eslintrc"] = "jsonc",
    ["*.snippets"] = "snippets",
  },
})
