return {
  -- this adds the stupid dashboard when opening nvim with no files selected
  { "nvimdev/dashboard-nvim", enabled = false },

  -- this uses sticky positioning at the top of the screen for the current
  -- scope. i.e. the current function or object
  -- when I have multiple buffers visible at once, it's too hard to track
  -- what's what.
  { "nvim-treesitter/nvim-treesitter-context", enabled = false },

  -- currently using Ultisnips instead
  { "L3MON4D3/LuaSnip", enabled = false },
  { "rafamadriz/friendly-snippets", enabled = false },
  { "saadparwaiz1/cmp_luasnip", enabled = false },

  -- Using nightfox with the colorblind mode
  { "folke/tokyonight.nvim", enabled = false },
  { "catppuccin/nvim", enabled = false },

  { "folke/persistence.nvim", enabled = false },
  { "dstein64/vim-startuptime", enabled = false },

  -- I normally don't search/replace multiple files at once so I haven't found
  -- a use for this yet. lsp refactor+rename has been good enough for me
  { "nvim-pack/nvim-spectre", enabled = false },

  -- I prefer only using "lukas-reineke/indent-blankline.nvim" since the
  -- indentation never really matters for me and this plugin makes it even
  -- noisier with animations. disabling the animation still makes it too
  -- visible
  {
    "echasnovski/mini.indentscope",
    enabled = false,
    -- uncommenting this requires all the indentscope dependencies
    -- opts = {
    --   draw = {
    --     animation = require("mini.indentscope").gen_animation.none(),
    --   },
    -- },
  },

  -- native lsp seem to work good enough without this
  { "mfussenegger/nvim-lint", enabled = false },

  -- this makes markdown too difficult to read as it switches between
  -- 'conceallevel' as you type and navigate through the file
  { "lukas-reineke/headlines.nvim", enabled = false },
}
