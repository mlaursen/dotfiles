return {
  {
    "folke/noice.nvim",
    opts = {
      routes = {
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "remote: Create a pull request" },
              { find = "remote: Create a merge request" },
              { find = "remote: To create a merge request" },
            },
          },
          view = "popup",
        },
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "cwd: " },
            },
          },
          opts = { skip = true },
        },
      },
    },
  },
  {
    "folke/edgy.nvim",
    opts = {
      animate = {
        enabled = false,
      },
      -- remove the git_status and buffers since I never use them
      left = {
        {
          title = "Neo-Tree",
          ft = "neo-tree",
          filter = function(buf, win)
            return vim.b[buf].neo_tree_source == "filesystem"
          end,
          pinned = true,
          open = "Neotree position=right filesystem",
        },
      },
    },
  },
}
