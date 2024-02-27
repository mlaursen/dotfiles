return {
  {
    "junegunn/fzf",
    dir = "~/.fzf",
    build = {
      "./install --all"
    },
    dependencies = {
      "junegunn/fzf.vim",
      {
        -- Updates additional commands that output to quickfix will be
        -- redirected into fzf
        "ojroques/nvim-lspfuzzy",
        config = function()
          require("lspfuzzy").setup {}
        end,
      }
    },
    config = function()
      vim.keymap.set("n", "<leader>t", ":FZF<cr>", { noremap = true })

      local fzf_action = {}
      fzf_action["ctrl-s"] = "split"
      fzf_action["ctrl-t"] = "tabedit"
      fzf_action["ctrl-v"] = "vsplit"
      vim.g.fzf_action = fzf_action

      local fzf_layout = {}
      fzf_layout["down"] = "~40%"
      vim.g.fzf_layout = fzf_layout
    end,
  },
  {
    "vim-scripts/BufOnly.vim",
    config = function()
      -- allows \bo to close all buffers except current focus
      vim.keymap.set("n", "<leader>bo", ":BufOnly<cr>")
      vim.keymap.set("n", "<leader>bb", ":Buffers<cr>")
    end,
  },
  {
    "airblade/vim-rooter",
    config = function()
      vim.g.rooter_patterns = { ".git" }
      vim.g.rooter_buftypes = { "" }
    end,
  },

  {
    "scrooloose/nerdtree",
    dependencies = {
      "Xuyuanp/nerdtree-git-plugin"
    },
    cmd = {
      "NERDTreeToggle",
      "NERDTreeFind",
    },
    keys = {
      { "<leader>]", "<cmd>NERDTreeToggle<cr>", desc = "NERDTreeToggle" },
      { "<leader>F", "<cmd>NERDTreeFind<cr>", desc = "NERDTreeFind" },
    },
    config = function()
      vim.g.NERDTreeShowHidden = 1
    end,
  }
}