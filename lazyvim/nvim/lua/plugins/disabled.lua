return {
  -- I use luasnips
  { "garymjr/nvim-snippets", enabled = false },
  -- I prefer my own snippets
  { "rafamadriz/friendly-snippets", enabled = false },

  -- Using nightfox with the colorblind mode
  { "folke/tokyonight.nvim", enabled = false },
  { "catppuccin/nvim", enabled = false },

  -- I prefer only using "lukas-reineke/indent-blankline.nvim" since the
  -- indentation never really matters for me and this plugin makes it even
  -- noisier with animations. disabling the animation still makes it too
  -- visible
  { "folke/flash.nvim", enabled = false },
  -- { "lewis6991/gitsigns.nvim",      enabled = false },

  -- seems to be breaking things
  { "nvim-mini/mini.ai", enabled = false },
  { "nvim-mini/mini.pairs", enabled = false },
}
