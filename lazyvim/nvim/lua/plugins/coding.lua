local function dump(o)
  if type(o) == "table" then
    local s = "{ "
    for k, v in pairs(o) do
      if type(k) ~= "number" then
        k = '"' .. k .. '"'
      end
      s = s .. "[" .. k .. "] = " .. dump(v) .. ","
    end
    return s .. "} "
  else
    return tostring(o)
  end
end

return {
  -- {
  --   "SirVer/ultisnips",
  --   dependencies = {
  --     "mlaursen/vim-react-snippets",
  --     "mlaursen/mlaursen-vim-snippets",
  --   },
  -- },
  -- {
  --   "L3MON4D3/LuaSnip",
  --   dependencies = {
  --     "mlaursen/vim-react-snippets",
  --     --   {
  --     --     "nvim-cmp",
  --     --     dependencies = {
  --     --       "saadparwaiz1/cmp_luasnip",
  --     --     },
  --     --     opts = function(_, opts)
  --     --       opts.snippet = {
  --     --         expand = function(args)
  --     --           require("luasnip").lsp_expand(args.body)
  --     --         end,
  --     --       }
  --     --       table.insert(opts.sources, { name = "luasnip" })
  --     --     end,
  --     --   },
  --   },
  -- },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "mlaursen/vim-react-snippets",
      -- "SirVer/ultisnips",
      -- "quangnguyen30192/cmp-nvim-ultisnips",
    },
    ---@param opts cmp.ConfigSchema
    opts = function()
      vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
      require("vim-react-snippets").lazy_load()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local compare = cmp.config.compare
      -- local defaults = require("cmp.config.default")()

      -- require("luasnip.loaders.from_lua").load({
      --   paths = "~/.local/share/nvim/lazy/vim-react-snippets/snippets",
      -- })

      return {
        auto_brackets = {},
        completion = {
          completeopt = vim.g.completeopt,
        },
        expand = function(args)
          luasnip.lsp_expand(args.body)
          -- vim.fn["UltiSnips#Anon"](args.body)
        end,
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          -- { name = "ultisnips" },
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

      -- using these mappings makes it so I can't tab within a snippet
      -- local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")

      -- opts.snippet = {
      --   expand = function(args)
      --     vim.fn["UltiSnips#Anon"](args.body)
      --   end,
      -- }
      -- opts.completion = {
      --   -- I like having to press tab to complete something while typing instead of
      --   -- having to select the item to complete it
      --   -- completeopt = "menu,preview",
      --   completeopt = vim.g.completeopt,
      -- }
      --
      -- table.insert(opts.sources, 2, { name = "ultisnips" })
      -- opts.mapping = cmp.mapping.preset.insert({
      --   -- ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
      --   -- ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      --   ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      --   ["<C-f>"] = cmp.mapping.scroll_docs(4),
      --   ["<C-e>"] = cmp.mapping.abort(),
      --
      --   ["<Tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
      --   ["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      --   -- ["<Tab>"] = cmp.mapping(function(fallback)
      --   --   cmp_ultisnips_mappings.jump_forwards(fallback)
      --   -- end, { "i", "s" }),
      --   -- ["<S-Tab>"] = cmp.mapping(function(fallback)
      --   --   cmp_ultisnips_mappings.jump_backwards(fallback)
      --   -- end, { "i", "s" }),
      --
      --   -- force the completion menu to appear
      --   ["<C-o>"] = cmp.mapping(function(fallback)
      --     if not cmp.visible() then
      --       cmp.complete()
      --     else
      --       fallback()
      --     end
      --   end, { "i", "s" }),
      --
      --   -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      --   ["<CR>"] = cmp.mapping.confirm({ select = false }),
      --
      --   -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      --   ["<S-CR>"] = cmp.mapping.confirm({
      --     behavior = cmp.ConfirmBehavior.Replace,
      --     select = false,
      --   }),
      -- })
    end,
  },

  {
    "tpope/vim-surround",
    -- enabled = false,
    event = { "InsertEnter", "VeryLazy" },
    ---@type LazyKeysSpec[]
    keys = {
      { "S", mode = "x", "<plug>VSurround" },
    },
  },
}
