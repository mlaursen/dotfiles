return {
  {
    "EdenEast/nightfox.nvim",
    config = function()
      require("nightfox").setup({
        options = {
          colorblind = {
            enable = true,
            -- simulate_only = true,
            severity = {
              protan = 0.8,
              deutan = 1,
              tritan = 0.3,
            },
          },
        },
        groups = {
          nightfox = {
            WinSeparator = { fg = "palette.cyan" },
          },
        },
      })
    end,
  },
}
