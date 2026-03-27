local use_copilot_auth = false
local use_copilot_chat = vim.env.USE_COPILOT == "true" and true or false

return {
  {
    -- minimal copy from `LazyExtra ai.copilot` that just enables the `Copilot
    -- auth` part. I don't want any of the suggestions
    "zbirenbaum/copilot.lua",
    enabled = use_copilot_auth,
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "BufReadPost",
    opts = {
      suggestion = {
        enabled = false,
        auto_trigger = false,
        hide_during_completion = true,
      },
    },
  },
  -- NOTE: Must enable CopilotChat extra as well for markup changes
  {
    "CopilotChat.nvim",
    enabled = use_copilot_chat,
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
