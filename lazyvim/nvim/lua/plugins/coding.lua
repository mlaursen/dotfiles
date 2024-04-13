return {
  {
    "SirVer/ultisnips",
    ft = "snippets",
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "mlaursen/vim-react-snippets",
      "mlaursen/mlaursen-vim-snippets",
    },
    ---@param opts cmp.ConfigSchema
    opts = function()
      vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
      require("vim-react-snippets").lazy_load()
      require("mlaursen-vim-snippets").lazy_load()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local compare = cmp.config.compare
      -- local defaults = require("cmp.config.default")()

      return {
        auto_brackets = {},
        completion = {
          completeopt = vim.g.completeopt,
        },
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
        }, {
          { name = "buffer" },
        }),
        sorting = {
          comparitors = {
            compare.offset,
            compare.exact,
            compare.score,
            compare.recently_used,
            compare.kind,
          },
        },
        -- sorting = defaults.sorting,
        formatting = {
          format = function(_, item)
            local icons = require("lazyvim.config").icons.kinds
            if icons[item.kind] then
              item.kind = icons[item.kind] .. item.kind
            end
            return item
          end,
        },
        experimental = {
          ghost_text = {
            hl_group = "CmpGhostText",
          },
        },
        mapping = cmp.mapping.preset.insert({
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
        }),
      }
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
