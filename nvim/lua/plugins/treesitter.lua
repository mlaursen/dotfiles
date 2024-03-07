return {
  "nvim-treesitter/nvim-treesitter",
  version = false,
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile", "VeryLazy" },
  cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
  opts = {
    highlight = { enable = true },
    indent = { enable = true },
    ensure_installed = {
      "bash",
      "css",
      "diff",
      "graphql",
      "html",
      "javascript",
      "jsdoc",
      "json",
      "jsonc",
      "lua",
      "luadoc",
      "luap",
      "markdown",
      "markdown_inline",
      "query",
      "regex",
      "scss",
      "tsx",
      "typescript",
      "vim",
      "vimdoc",
      "yaml",
    },
  },

  config = function(_, opts)
    if type(opts.ensure_installed) == "table" then
      ---@type table<string, boolean>
      local added = {}
      opts.ensure_installed = vim.tbl_filter(function(lang)
        if added[lang] then
          return false
        end
        added[lang] = true
        return true
      end, opts.ensure_installed)
    end
    require("nvim-treesitter.configs").setup(opts)

    -- local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
    --
    -- parser_config.tsx.filetype_to_parsername = {
    --   "typescriptreact",
    --   "typescript.tsx",
    --   "javascript",
    -- }
    -- vim.treesitter.language.register("markdown", "mdx")
  end,
}
