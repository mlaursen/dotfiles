return {
  "folke/noice.nvim",
  opts = {
    routes = {
      {
        filter = {
          event = "msg_show",
          any = {
            { find = "remote" },
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
