return {
  { "nvim-neotest/neotest-jest" },
  {
    "nvim-neotest/neotest",
    opts = {
      adapters = {
        ["neotest-jest"] = {
          args = {},
        },
      },
    },
  },
}
