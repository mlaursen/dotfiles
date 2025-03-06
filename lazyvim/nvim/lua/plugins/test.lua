return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/neotest-jest",
      "marilari88/neotest-vitest",
    },
    opts = function(_, opts)
      if vim.g.current_neotest_framework == "jest" then
        table.insert(
          opts.adapters,
          require("neotest-jest")({
            -- see section around monorepos
            cwd = function(file)
              if string.find(file, "/packages/") then
                return string.match(file, "(.-/[^/]+/)src")
              end

              return vim.fn.getcwd()
            end,
            jestCommand = function(file)
              -- when running in the react-md monorepo, I want to use `pnpm test` when running all tests
              -- since it uses turbo to run
              if string.match(file, "react%-md$") then
                return "pnpm test -- --"
              end

              return require("neotest-jest.jest-util").getJestCommand(vim.fn.expand("%:p:h"))
            end,
          })
        )
      end

      if vim.g.current_neotest_framework == "vitest" then
        table.insert(opts.adapters, require("neotest-vitest")({}))
      end
    end,
  },
}
