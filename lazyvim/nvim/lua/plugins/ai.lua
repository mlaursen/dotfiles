local use_code_companion = true
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
  {
    "CopilotChat.nvim",
    enabled = not use_code_companion,
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
  {
    "ravitemer/mcphub.nvim",
    enabled = use_code_companion,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    build = "npm install -g mcp-hub@latest", -- Installs `mcp-hub` node binary globally
    config = function()
      require("mcphub").setup()
    end,
  },
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "ravitemer/mcphub.nvim",
    },
    enabled = use_code_companion,
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
      -- {
      --   "<leader>aq",
      --   function()
      --     vim.ui.input({
      --       prompt = "Quick Chat: ",
      --     }, function(input)
      --       if input ~= "" then
      --         require("codecompanion").chat({ input })
      --       end
      --     end)
      --   end,
      --   desc = "Quick Chat (CopilotChat)",
      --   mode = { "n", "v" },
      -- },
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
          mcphub = {
            callback = "mcphub.extensions.codecompanion",
            opts = {
              make_vars = true,
              make_slash_commands = true,
              show_result_in_chat = true,
            },
          },
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
                  n = "gx",
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
