return {
  {
    -- minimal copy from `LazyExtra ai.copilot` that just enables the `Copilot
    -- auth` part. I don't want any of the suggestions
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "BufReadPost",
    opts = {
      suggestion = {
        enabled = false,
        auto_trigger = true,
        hide_during_completion = true,
      },
    },
  },
  -- NOTE: Must enable CopilotChat extra as well for markup changes
  -- {
  --   "CopilotChat.nvim",
  --   enabled = not use_code_companion,
  --   opts = {
  --     -- window = {
  --     --   layout = "float",
  --     -- },
  --     auto_insert_mode = false,
  --     mappings = {
  --       reset = {
  --         normal = "<C-r>",
  --         insert = "<C-r>",
  --       },
  --     },
  --   },
  -- },

  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      {
        "ravitemer/mcphub.nvim",
        enabled = false,
        dependencies = {
          "nvim-lua/plenary.nvim",
        },
        build = "npm install -g mcp-hub@latest",
        config = function()
          require("mcphub").setup()
        end,
      },
    },
    keys = {
      { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
      {
        "<leader>aa",
        function()
          require("codecompanion").toggle()
        end,
        desc = "Toggle (CodeCompanion Chat)",
        mode = { "n", "v" },
      },
      {
        "<leader>ap",
        function()
          require("codecompanion").actions()
        end,
        desc = "Run CodeCompanion Tool",
      },
      {
        "q",
        ft = "codecompanion",
        desc = "Toggle (CodeCompanion Chat)",
        remap = true,
        mode = { "n" },
      },
    },
    config = function()
      require("codecompanion").setup({
        adapters = {
          -- ollama = {
          --   model = "devstral",
          --   host = "http://localhost:11434",
          -- },
        },
        -- default_adapter = "ollama",
        extensions = {
          -- mcphub = {
          --   callback = "mcphub.extensions.codecompanion",
          --   opts = {
          --     make_vars = true,
          --     make_slash_commands = true,
          --     show_result_in_chat = true,
          --   },
          -- },
        },
        display = {
          chat = {
            window = {
              opts = {
                relativenumber = false,
                number = false,
              },
            },
          },
          diff = {
            enabled = true,
            -- close_chat_at = 240, -- Close an open chat buffer if the total columns of your display are less than...
            -- layout = "vertical", -- vertical|horizontal split for default provider
            -- opts = { "internal", "filler", "closeoff", "algorithm:patience", "followwrap", "linematch:120" },
            -- provider = "default", -- default|mini_diff
          },
        },
        strategies = {
          chat = {
            roles = {
              user = vim.env.USER or "Me",
            },
            keymaps = {
              close = {
                modes = {
                  n = "gq",
                },
                index = 4,
                callback = "keymaps.close",
                description = "Close Chat",
              },
              stop = {
                modes = {
                  n = "<c-x>",
                },
                index = 5,
                callback = "keymaps.stop",
                description = "Stop Request",
              },
              clear = {
                modes = {
                  -- do not use the default of gx since it means I can't open links
                  n = "gR",
                },
                index = 6,
                callback = "keymaps.clear",
                description = "Clear Chat",
              },
            },
          },
        },
      })
    end,
  },

  {
    "folke/edgy.nvim",
    optional = true,
    opts = function(_, opts)
      opts.right = opts.right or {}
      table.insert(opts.right, {
        ft = "codecompanion",
        title = "CodeCompanion Chat",
        size = { width = 50 },
      })
    end,
  },
}