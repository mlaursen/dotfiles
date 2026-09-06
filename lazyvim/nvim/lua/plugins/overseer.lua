-- just for the type definitions
require("lazyvim")

return {
  "stevearc/overseer.nvim",
  opts = {
    templates = { "builtin", "project_file" },
  },
  keys = {
    {
      "<leader>oT",
      function()
        local overseer = require("overseer")
        local task_editor = require("overseer.task_editor")

        local task = overseer.new_task({
          name = "New Task",
          cmd = "",
          cwd = LazyVim.root(),
        })

        task_editor.open(task, function(t)
          if t then
            t:start()
          end
        end)
      end,
      desc = "Overseer: New Task",
    },
  },
}
