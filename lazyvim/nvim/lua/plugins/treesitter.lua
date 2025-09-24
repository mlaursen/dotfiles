return {
  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   opts = function(_, opts)
  --     local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
  --
  --     -- the default [tree-sitter-scss](https://github.com/serenadeai/tree-sitter-scss) is unmaintained
  --     -- and doesn't support everything that actually matters:
  --     -- - maps, !default, @use, @forward, variable properties, ...etc
  --     parser_config.scss.install_info.url = "https://github.com/savetheclocktower/tree-sitter-scss"
  --
  --     -- https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#supported-languages
  --     vim.list_extend(opts.ensure_installed, {
  --       "scss",
  --     })
  --
  --     opts.highlight.disable = { "scss" }
  --   end,
  -- },
}
