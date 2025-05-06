return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      { "nvim-neotest/neotest-jest", url = "https://github.com/mlaursen/neotest-jest" },
      { "marilari88/neotest-vitest", url = "https://github.com/mlaursen/neotest-vitest" },
    },

    keys = {
      {
        "<leader>tu",
        function()
          local neotest = require("neotest")
          neotest.run.run({
            vim.fn.expand("%:p"),
            suite = false,
            extra_args = { "-u" },
          })
        end,
      },
    },
    opts = {
      adapters = {
        -- if I need to override stuff, just add a `.lazy.lua` to the repo to add additional config
        ["neotest-vitest"] = {},
        ["neotest-jest"] = {
          -- see section around monorepos
          cwd = function(file)
            if string.find(file, "/packages/") then
              return string.match(file, "(.-/[^/]+/)src")
            end

            return vim.fn.getcwd()
          end,
        },
      },
    },
  },
}
