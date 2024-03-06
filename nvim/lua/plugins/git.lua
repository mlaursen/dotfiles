return {
  "tpope/vim-fugitive",
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
    },
    -- config = function()
    --   local gs = require("gitsigns")
    --   gs.setup({
    --     on_attach = function(bufnr)
    --       local function map(mode, l, r, opts)
    --         opts = opts or {}
    --         opts.buffer = bufnr
    --
    --         vim.keymap.set(mode, l, r, opts)
    --       end
    --
    --       map("n", "]c", function()
    --         if vim.wo.diff then return "]c" end
    --         vim.schedule(function() require("gitsigns").next_hunk() end)
    --         return "<Ignore>"
    --       end, { expr = true })
    --       map("n", "[c", function()
    --         if vim.wo.diff then return "[c" end
    --         vim.schedule(function() require("gitsigns").prev_hunk() end)
    --         return "<Ignore>"
    --       end, { expr = true })
    --
    --       map("n", "=", function()
    --         gs.diffthis("~")
    --       end)
    --     end,
    --   })
    -- end,
    keys = {
      {
        "]c",
        function()
          if vim.wo.diff then return "]c" end
          vim.schedule(function() require("gitsigns").next_hunk() end)
          return "<Ignore>"
        end,
      },
      {
        "[c",
        function()
          if vim.wo.diff then return "]c" end
          vim.schedule(function() require("gitsigns").prev_hunk() end)
          return "<Ignore>"
        end,
      },
      {
        "=",
        function()
          if vim.wo.diff then return "=" end
          vim.schedule(function() require("gitsigns").diffthis("~") end)
          return "<Ignore>"
        end
      },
    }
  },
}