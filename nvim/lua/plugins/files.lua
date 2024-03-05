return {
  {
    "junegunn/fzf",
    dir = "~/.fzf",
    build = {
      "./install --all"
    },
    dependencies = {
      "junegunn/fzf.vim",
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
  },
  -- {
  --   "airblade/vim-rooter",
  --   config = function()
  --     vim.g.rooter_patterns = { ".git" }
  --     vim.g.rooter_buftypes = { "" }
  --   end,
  -- },

  -- {
  --   "scrooloose/nerdtree",
  --   dependencies = {
  --     "Xuyuanp/nerdtree-git-plugin"
  --   },
  --   cmd = {
  --     "NERDTreeToggle",
  --     "NERDTreeFind",
  --   },
  --   keys = {
  --     { "<leader>]", "<cmd>NERDTreeToggle<cr>", desc = "NERDTreeToggle" },
  --     { "<leader>F", "<cmd>NERDTreeFind<cr>", desc = "NERDTreeFind" },
  --   },
  --   config = function()
  --     vim.g.NERDTreeShowHidden = 1
  --   end,
  -- },
}