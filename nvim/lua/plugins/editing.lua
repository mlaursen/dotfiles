return {
  "tpope/vim-fugitive",
  -- "tpope/vim-sensible",
  -- "tpope/vim-surround",
  -- mostly used so that vim-surround can be repeated
  -- "tpope/vim-repeat",
  -- easy comments with `gc` or `gcc`
  -- "tpope/vim-commentary",

  {
    "matze/vim-move",
    config = function()
      vim.g.move_key_modifier = "C"
      vim.g.move_map_keys = 0
      vim.g.move_auto_indent = 0
      vim.keymap.set("v", "<C-j>", "<Plug>MoveBlockDown")
      vim.keymap.set("v", "<C-k>", "<Plug>MoveBlockUp")
    end,
  },

  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    config = function(_, opts)
      require("mini.pairs").setup(opts)
    end,
  },

  {
    "echasnovski/mini.comment",
    event = "VeryLazy",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
      event = "VeryLazy",
      lazy = true,
    },
    opts = {
      hooks = {
        pre = function()
          require("ts_context_commentstring.internal").update_commentstring({})
        end,
      },
    },
    config = function(_, opts)
      require("mini.comment").setup(opts)
    end,
  },

  {
    "echasnovski/mini.surround",
    event = "VeryLazy",
    opts = {
      mappings = {
        add = "S",
        delete = "ds",
        replace = "cs",
      },
    },
    config = function(_, opts)
      require("mini.surround").setup(opts)
    end,
  },
}