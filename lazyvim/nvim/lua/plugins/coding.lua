return {
  {
    "SirVer/ultisnips",
    ft = "snippets",
  },

  {
    "L3MON4D3/LuaSnip",
    ---@type LazyKeysSpec[]
    keys = {
      { "<tab>", mode = { "i", "s" }, false },
      { "<s-tab>", mode = { "i", "s" }, false },
    },
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "mlaursen/vim-react-snippets",
      "mlaursen/mlaursen-vim-snippets",
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      require("vim-react-snippets").lazy_load()
      require("mlaursen-vim-snippets").lazy_load()

      opts.completion = {
        completeopt = vim.g.completeopt,
      }
      opts.mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-e>"] = cmp.mapping.abort(),

        ["<Tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),

        -- force the completion menu to appear
        ["<C-o>"] = cmp.mapping(function(fallback)
          if not cmp.visible() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),

        -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<CR>"] = cmp.mapping.confirm({ select = false }),

        -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<S-CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        }),

        ["<C-j>"] = cmp.mapping(function(callback)
          if luasnip.locally_jumpable(1) then
            luasnip.jump(1)
          else
            callback()
          end
        end, { "i", "s" }),

        ["<C-k>"] = cmp.mapping(function(callback)
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            callback()
          end
        end, { "i", "s" }),

        -- allow ctrl-space to expand luasnip snippets like UltiSnips
        ["<C-Space>"] = cmp.mapping(function(fallback)
          if luasnip.expandable() then
            luasnip.expand()
          else
            fallback()
          end
        end, { "i", "s" }),
      })
    end,
  },

  {
    "tpope/vim-surround",
    event = { "InsertEnter", "VeryLazy" },
    ---@type LazyKeysSpec[]
    keys = {
      { "S", mode = "x", "<plug>VSurround" },
    },
  },
}
