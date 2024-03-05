return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  cmd = "Neotree",
  deactivate = function()
    vim.cmd([[Neotree close]])
  end,
  opts = {
    filesystem = {
      filtered_items = {
        hide_dotfiles = false,
        always_show = {
          ".env.local",
          ".env.development.local",
          ".env.production.local",
        },
      },
    },
  },
  keys = {
    {
      "<leader>F",
      function()
        local reveal_file = vim.fn.expand('%:p')
        if (reveal_file == '') then
          reveal_file = vim.fn.getcwd()
        else
          local f = io.open(reveal_file, "r")
          if (f) then
            f.close(f)
          else
            reveal_file = vim.fn.getcwd()
          end
        end

        require("neo-tree.command").execute({
          reveal_file = reveal_file,
          reveal_force_cwd = true,
        })
      end,
      desc = "Reveal current file/directory in Neotree",
    },
    {
      "<leader>]",
      function()
        require("neo-tree.command").execute({ toggle = true })
      end,
      desc = "Toggle Neotree",
    }
  },
  config = function(_, opts)
    require("neo-tree").setup(opts)
  end,
}