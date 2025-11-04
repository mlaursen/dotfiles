return {
  {
    "EdenEast/nightfox.nvim",
    opts = {
      options = {
        colorblind = {
          enable = true,
          -- simulate_only = true,
          severity = {
            protan = 0.2,
            deutan = 0.9,
            tritan = 0.1,
          },
        },
      },
      groups = {
        nightfox = {
          WinSeparator = { fg = "palette.cyan" },
        },
      },
    },
  },
}
