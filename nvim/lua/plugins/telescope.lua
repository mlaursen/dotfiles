return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
  },
  lazy = true,
  cmd = "Telescope",
  keys = {
    {
      "<leader>t",
      function()
        require("telescope.builtin").find_files()
      end,
    },
    {
      "<leader>gg",
      function()
        require("telescope.builtin").live_grep()
      end,
    },
    {
      "<leader>bb",
      function()
        require("telescope.builtin").buffers()
      end,
    },
    {
      "<leader>h",
      function()
        require("telescope.builtin").help_tags()
      end,
    },

    {
      "<leader>gc",
      function()
        require("telescope.builtin").git_commits()
      end,
    },
    {
      "<leader>gb",
      function()
        require("telescope.builtin").git_branches()
      end,
    },
    {
      "<leader>gs",
      function()
        require("telescope.builtin").git_status()
      end,
    },
    {
      "<leader>gS",
      function()
        require("telescope.builtin").git_stash()
      end,
    },
  },
  config = function()
    require("telescope").setup({
      defaults = {
        mappings = {
          i = {
            ["<C-s>"] = require("telescope.actions").select_horizontal,
          },
        },
      },
      pickers = {
        find_files = {
          hidden = true,
        },
        file_browser = {
          hidden = true,
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          case_mode = "smart_case",
          override_file_sorter = true,
          override_generic_sorter = true,
        },
      },
    })
    require("telescope").load_extension("fzf")
  end,
}
