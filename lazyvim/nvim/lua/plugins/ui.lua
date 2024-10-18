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
    },
  },
}
