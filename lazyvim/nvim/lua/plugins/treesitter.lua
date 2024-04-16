return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#supported-languages
      vim.list_extend(opts.ensure_installed, {
        "css",
        -- removed since it doesn't work for: maps, !default, @use, @forward, variables as properties
        -- "scss",
      })
    end,
    -- opts = {
    --   ensure_installed = {
    --     "bash",
    --     -- "c",
    --     "css",
    --     "diff",
    --     "html",
    --     "javascript",
    --     "jsdoc",
    --     "json",
    --     "jsonc",
    --     "lua",
    --     "luadoc",
    --     "luap",
    --     "markdown",
    --     "markdown_inline",
    --     -- "python",
    --     "query",
    --     "regex",
    --     "scss",
    --     -- "toml",
    --     "tsx",
    --     "typescript",
    --     "vim",
    --     "vimdoc",
    --     "xml",
    --     "yaml",
    --   },
    -- },
  },
}
