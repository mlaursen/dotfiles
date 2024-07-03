return {
  "folke/noice.nvim",
  opts = {
    routes = {
      {
        filter = {
          event = "msg_show",
          any = {
            { find = "remote: Create a pull request" },
            { find = "remote: Create a merge request" },
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
}
