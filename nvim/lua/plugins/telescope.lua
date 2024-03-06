return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
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
      pickers = {
        find_files = {
          hidden = true,
        },
        file_browser = {
          hidden = true,
        },
      },
    })
  end,
}