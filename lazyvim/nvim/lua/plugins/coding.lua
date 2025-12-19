return {
  {
    -- for the syntax highlighting only
    "SirVer/ultisnips",
    ft = "snippets",
    enabled = false,
    config = function()
      vim.g.UltiSnipsExpandTrigger = "<c-space>"
      vim.g.UltiSnipsSnippetDirectories = {
        "UltiSnips",
        os.getenv("HOME") .. "/code/react-md/UltiSnips",
      }
    end,
  },

  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    dependencies = {
      {
        "mlaursen/vim-react-snippets",
        -- dir = "~/code/vim-react-snippets",
        opts = {},
      },
      {
        "mlaursen/mlaursen-vim-snippets",
        -- dir = "~/code/mlaursen-vim-snippets",
        opts = {},
      },
    },
    ---@type LazyKeysSpec[]
    keys = {
      { "<tab>", mode = { "i", "s" }, false },
      { "<s-tab>", mode = { "i", "s" }, false },
      {
        "<C-Space>",
        mode = { "i", "s" },
        function()
          local ls = require("luasnip")

          -- need to call ls.expandable() first so that any "cached" snippet is
          -- correctly refreshed
          if ls.expandable() then
            ls.expand({})
          end
        end,
      },
    },
  },

  {
    "saghen/blink.compat",
    -- use the latest release, via version = '*', if you also use the latest release for blink.cmp
    version = "*",
    -- lazy.nvim will automatically load the plugin when it's required by blink.cmp
    lazy = true,
    -- make sure to set opts so that lazy.nvim calls blink.compat's setup
    opts = {},
  },

  {
    "saghen/blink.cmp",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "moyiz/blink-emoji.nvim",
      "hrsh7th/cmp-calc",
    },
    opts = {
      sources = {
        default = {
          "emoji",
          "calc",
        },
        providers = {
          emoji = {
            module = "blink-emoji",
            name = "Emoji",
            score_offset = 15,
            opts = { insert = true },
          },
          calc = {
            name = "calc",
            module = "blink.compat.source",
          },
        },
      },
      completion = {
        ghost_text = {
          enabled = false,
        },
        list = {
          selection = {
            auto_insert = true,
            preselect = false,
          },
        },
      },
      snippets = {
        -- make it so it only jumps. it should not expand stuff like the default implementation
        jump = function(direction)
          local ls = require("luasnip")
          return ls.jumpable(direction) and ls.jump(direction)
        end,
      },
      keymap = {
        preset = "none",
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<C-y>"] = { "fallback" },
        -- I can't get blink to work with it since it expects the snippet to be
        -- in the menu before selecting. I don't care about that and just want
        -- snippet to work. use the luasnip keymap instead
        ["<C-Space>"] = { "fallback" },
        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
        ["<C-j>"] = { "snippet_forward", "fallback" },
        ["<C-k>"] = { "snippet_backward", "fallback" },
        ["<C-o>"] = { "show", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
      },
    },
  },

  {
    "tpope/vim-surround",
    event = { "InsertEnter", "VeryLazy" },
    ---@type LazyKeysSpec[]
    keys = {
      { "S", mode = "x", "<plug>VSurround" },
    },
  },

  {
    "tpope/vim-repeat",
    event = { "InsertEnter", "VeryLazy" },
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },
}
