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
      "<leader>g",
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
    }
  }
}