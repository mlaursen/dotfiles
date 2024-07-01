return {
  -- this adds the stupid dashboard when opening nvim with no files selected
  { "nvimdev/dashboard-nvim", enabled = false },

  -- this uses sticky positioning at the top of the screen for the current
  -- scope. i.e. the current function or object
  -- when I have multiple buffers visible at once, it's too hard to track
  -- what's what.
  { "nvim-treesitter/nvim-treesitter-context", enabled = false },

  -- I use luasnips
  { "garymjr/nvim-snippets", enabled = false },
  -- I prefer my own snippets
  { "rafamadriz/friendly-snippets", enabled = false },

  -- Using nightfox with the colorblind mode
  -- { "folke/tokyonight.nvim", enabled = false },
  -- { "catppuccin/nvim", enabled = false },

  -- I prefer only using "lukas-reineke/indent-blankline.nvim" since the
  -- indentation never really matters for me and this plugin makes it even
  -- noisier with animations. disabling the animation still makes it too
  -- visible
  { "folke/flash.nvim", enabled = false },
  { "lewis6991/gitsigns.nvim", enabled = false },

  { "echasnovski/mini.pairs", enabled = false },

  -- this makes markdown too difficult to read as it switches between
  -- 'conceallevel' as you type and navigate through the file
  { "lukas-reineke/headlines.nvim", enabled = false },
}
