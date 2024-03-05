return {
  {
    "vim-scripts/BufOnly.vim",
    config = function()
      -- allows \bo to close all buffers except current focus
      vim.keymap.set("n", "<leader>bo", ":BufOnly<cr>")
      -- vim.keymap.set("n", "<leader>bb", ":Buffers<cr>")
    end,
  },

  {
    "airblade/vim-rooter",
    config = function()
      vim.g.rooter_patterns = { ".git" }
      vim.g.rooter_buftypes = { "" }
    end,
  },
}