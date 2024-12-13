return {
  {
    -- for the syntax highlighting only
    "SirVer/ultisnips",
    ft = "snippets",
  },

  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    dependencies = {
      "mlaursen/vim-react-snippets",
      "mlaursen/mlaursen-vim-snippets",
    },
    ---@type LazyKeysSpec[]
    keys = {
      { "<tab>", mode = { "i", "s" }, false },
      { "<s-tab>", mode = { "i", "s" }, false },
    },
    opts = function()
      require("vim-react-snippets").lazy_load()
      require("mlaursen-vim-snippets").lazy_load()
    end,
  },

  {
    "saghen/blink.cmp",
    dependencies = { "L3MON4D3/LuaSnip", version = "v2.*" },
    opts = {
      completion = {
        ghost_text = {
          enabled = false,
        },
        list = {
          selection = "auto_insert",
        },
      },
      keymap = {
        preset = "default",
        ["<Tab>"] = { "select_next" },
        ["<S-Tab>"] = { "select_prev" },
        ["<C-space>"] = {
          function(cmp)
            if cmp.snippet_active() then
              return cmp.accept()
            end
            return cmp.select_and_accept()
          end,
        },
        ["<C-j>"] = { "snippet_forward", "fallback" },
        ["<C-k>"] = { "snippet_backward", "fallback" },
        ["<C-o>"] = { "show" },
        ["<Enter>"] = { "select_and_accept" },

        -- disable default keymaps
        ["<C-e>"] = {},
        ["<C-y>"] = {},
        ["<C-p>"] = {},
        ["<C-n>"] = {},
      },
    },
  },

  -- {
  --   "hrsh7th/nvim-cmp",
  --   dependencies = {
  --     "hrsh7th/cmp-emoji",
  --     "hrsh7th/cmp-calc",
  --     "petertriho/cmp-git",
  --   },
  --   ---@type LazyKeysSpec[]
  --   keys = {
  --     { "<tab>", mode = { "i", "s" }, false },
  --     { "<s-tab>", mode = { "i", "s" }, false },
  --   },
  --   ---@param opts cmp.ConfigSchema
  --   opts = function(_, opts)
  --     local cmp = require("cmp")
  --     local luasnip = require("luasnip")
  --
  --     table.insert(opts.sources, { name = "emoji" })
  --     table.insert(opts.sources, { name = "calc" })
  --     table.insert(opts.sources, { name = "git" })
  --
  --     require("cmp_git").setup()
  --
  --     opts.completion = {
  --       completeopt = vim.g.completeopt,
  --     }
  --     opts.sorting = {
  --       priority_weight = 2.0,
  --       comparators = {
  --         cmp.config.compare.exact,
  --         cmp.config.compare.offset,
  --         cmp.config.compare.score,
  --         cmp.config.compare.order,
  --         cmp.config.compare.locality,
  --         cmp.config.compare.recently_used,
  --       },
  --     }
  --     opts.mapping = cmp.mapping.preset.insert({
  --       ["<C-b>"] = cmp.mapping.scroll_docs(-4),
  --       ["<C-f>"] = cmp.mapping.scroll_docs(4),
  --       ["<C-e>"] = cmp.mapping.abort(),
  --
  --       ["<Tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
  --       ["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
  --
  --       -- force the completion menu to appear
  --       ["<C-o>"] = cmp.mapping(function(fallback)
  --         if not cmp.visible() then
  --           cmp.complete()
  --         else
  --           fallback()
  --         end
  --       end, { "i", "s" }),
  --
  --       -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  --       ["<CR>"] = cmp.mapping.confirm({ select = false }),
  --
  --       -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  --       ["<S-CR>"] = cmp.mapping.confirm({
  --         behavior = cmp.ConfirmBehavior.Replace,
  --         select = false,
  --       }),
  --
  --       ["<C-j>"] = cmp.mapping(function(callback)
  --         if luasnip.locally_jumpable(1) then
  --           luasnip.jump(1)
  --         else
  --           callback()
  --         end
  --       end, { "i", "s" }),
  --
  --       ["<C-k>"] = cmp.mapping(function(callback)
  --         if luasnip.locally_jumpable(-1) then
  --           luasnip.jump(-1)
  --         else
  --           callback()
  --         end
  --       end, { "i", "s" }),
  --
  --       -- allow ctrl-space to expand luasnip snippets like UltiSnips
  --       ["<C-Space>"] = cmp.mapping(function(fallback)
  --         if luasnip.expandable() then
  --           luasnip.expand()
  --         else
  --           fallback()
  --         end
  --       end, { "i", "s" }),
  --     })
  --     opts.experimental.ghost_text = false
  --   end,
  -- },

  {
    "tpope/vim-surround",
    event = { "InsertEnter", "VeryLazy" },
    ---@type LazyKeysSpec[]
    keys = {
      { "S", mode = "x", "<plug>VSurround" },
    },
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
  },

  {
    "tpope/vim-repeat",
    event = { "InsertEnter", "VeryLazy" },
  },

  {
    "CopilotChat.nvim",
    opts = {
      -- window = {
      --   layout = "float",
      -- },
      auto_insert_mode = false,
      mappings = {
        reset = {
          normal = "<C-r>",
          insert = "<C-r>",
        },
      },
    },
  },
}
