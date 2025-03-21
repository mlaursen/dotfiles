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
      "mlaursen/vim-react-snippets",
      "mlaursen/mlaursen-vim-snippets",
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
          ls.expand()
        end,
      },
    },
    opts = function()
      require("vim-react-snippets").lazy_load()
      require("mlaursen-vim-snippets").lazy_load()

      if vim.g.is_blink_enabled then
        -- defaults to `NonText` which is not visible for me with the menu bg
        vim.api.nvim_set_hl(0, "BlinkCmpLabelDescription", { link = "Comment" })
      end
    end,
  },

  {
    "saghen/blink.cmp",
    enabled = vim.g.is_blink_enabled,
    dependencies = {
      "L3MON4D3/LuaSnip",
      "moyiz/blink-emoji.nvim",
    },
    opts = {
      sources = {
        default = {
          "emoji",
        },
        providers = {
          emoji = {
            module = "blink-emoji",
            name = "Emoji",
            score_offset = 15,
            opts = { insert = true },
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
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-calc",
      "petertriho/cmp-git",
    },
    enabled = not vim.g.is_blink_enabled,
    ---@type LazyKeysSpec[]
    keys = {
      { "<tab>", mode = { "i", "s" }, false },
      { "<s-tab>", mode = { "i", "s" }, false },
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      table.insert(opts.sources, { name = "emoji" })
      table.insert(opts.sources, { name = "calc" })
      table.insert(opts.sources, { name = "git" })

      require("cmp_git").setup()

      opts.completion = {
        completeopt = vim.g.completeopt,
      }
      opts.sorting = {
        priority_weight = 2.0,
        comparators = {
          cmp.config.compare.exact,
          cmp.config.compare.offset,
          cmp.config.compare.score,
          cmp.config.compare.order,
          cmp.config.compare.locality,
          cmp.config.compare.recently_used,
        },
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
      opts.experimental.ghost_text = false
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
