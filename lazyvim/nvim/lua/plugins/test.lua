local function find_root(path)
  local found = vim.fs.find("package.json", {
    path = vim.fn.fnamemodify(path, ":h"),
    upward = true,
  })[1]
  return found and vim.fn.fnamemodify(found, ":h") or vim.fn.getcwd()
end

return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      { "marilari88/neotest-vitest" },
      -- { "marilari88/neotest-vitest", url = "https://github.com/mlaursen/neotest-vitest" },
      -- { "nvim-neotest/neotest-jest", url = "https://github.com/mlaursen/neotest-jest" },
      { "nvim-neotest/neotest-jest" },
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
        desc = "Update Snapshot (Neotest)",
      },
    },
    opts = {
      adapters = {
        -- if I need to override stuff, just add a `.lazy.lua` to the repo to add additional config
        ["neotest-vitest"] = {
          filter_dir = function(name, rel_path, root)
            return name ~= "node_modules" and name ~= "__snapshots__"
          end,
        },
        ["neotest-jest"] = {
          -- see section around monorepos
          cwd = function(file)
            return find_root(file)
          end,
          env = {
            NODE_OPTIONS = "--experimental-vm-modules",
            NODE_NO_WARNINGS = 1,
          },
          jestConfigFile = function(path)
            return find_root(path) .. "/jest.config.js"
          end,
        },
      },
    },
  },
}
