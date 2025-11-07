local use_claude_code = vim.env.ANTHROPIC_API_KEY and vim.env.ANTHROPIC_API_KEY ~= "" and true or false

return {
  {
    -- minimal copy from `LazyExtra ai.copilot` that just enables the `Copilot
    -- auth` part. I don't want any of the suggestions
    "zbirenbaum/copilot.lua",
    enabled = not use_claude_code,
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
  {
    "CopilotChat.nvim",
    enabled = not use_claude_code,
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
    "coder/claudecode.nvim",
    opts = {
      terminal = {
        ---@module "snacks"
        ---@type snacks.win.Config|{}
        snacks_win_opts = {
          position = "float",
          width = 0.9,
          height = 0.9,
        },
      },
    },
  },
}
