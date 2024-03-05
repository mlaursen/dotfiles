return {
  "SirVer/ultisnips",
  dependencies = {
    "mlaursen/vim-react-snippets",
    "mlaursen/mlaursen-vim-snippets",
  },
  config = function()
    vim.g.UltiSnipsExpandTrigger = "<c-space>"
    vim.g.UltiSnipsSnippetDirectories = {
      "UltiSnips",
      os.getenv("HOME") .. "/code/react-md/UltiSnips",
    }
  end,
}