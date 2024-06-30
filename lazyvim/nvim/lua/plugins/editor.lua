return {
  {
    "tpope/vim-fugitive",
    lazy = "VeryLazy",
    cmd = {
      "Git",
      "Gwrite",
      "Gread",
      "Gvdiffsplit",
    },
    ---@type LazyKeysSpec[]
    keys = {
      { "<leader>gg", "<cmd>Git<cr>", desc = "Git (fugitive)" },
      { "<leader>gB", "<cmd>Git blame<cr>", desc = "blame" },
      { "<leader>gp", "<cmd>Git pruneall<cr>", desc = "pull and prune" },
      { "<leader>gP", "<cmd>Git push -u origin HEAD<cr>", desc = "push" },
      { "<leader>gl", "<cmd>Git log<cr>", desc = "log" },
      { "<leader>gD", "<cmd>Gvdiffsplit!<cr>", desc = "Diff split (vertical)" },
    },
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        -- follow_current_file = { enabled = false },
        filtered_items = {
          always_show = {
            ".env.local",
            ".env.development.local",
            ".env.production.local",
          },
          hide_dotfiles = false,
        },
      },
      window = {
        mappings = {
          ["a"] = {
            "add",
            config = {
              show_path = "relative",
            },
          },
          ["m"] = {
            "move",
            config = {
              show_path = "relative",
            },
          },
        },
      },
    },
  },

  {
    "telescope.nvim",
    enabled = false,
    opts = {
      defaults = {
        hidden = true,
        vimgrep_arguments = {
          -- default
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",

          -- same as find command, without following symlinks and single files
          -- "--files",
          -- "--follow",
          "--hidden",
          "--iglob",
          "!.git",
        },
      },
      pickers = {
        find_files = {
          -- I want to be able to fuzzy find dotfiles like
          -- - `.env` (tracked)
          -- - `.swcrc`
          -- - `.changeset/what-ever.md`
          -- - `.github/workflow/main.yml`
          --
          -- this still doesn't work for ignored .env*.local files though
          find_command = {
            "rg",
            "--files",
            "--follow",
            "--hidden",
            "--iglob",
            "!.git",
          },
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
    },
    keys = {
      {
        "<leader>fd",
        "<cmd>Telescope find_files no_ignore=true hidden=true search_file=\\.env initial_mode=normal<cr>",
        desc = "Find dot env files",
      },
      {
        "<leader>gb",
        "<cmd>Telescope git_branches<cr>",
        desc = "Git branch",
      },
      {
        "<leader>gs",
        "<cmd>Telescope git_stash initial_mode=normal<cr>",
        desc = "Git stash",
      },
      {
        "zf",
        "<cmd>Telescope spell_suggest<cr>",
        desc = "z= but with telescope",
      },
    },
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function()
          require("telescope").load_extension("fzf")
        end,
      },
    },
  },

  {
    "vimwiki/vimwiki",
    cmd = {
      "VimwikiDiaryIndex",
      "VimwikiMakeDiaryNote",
    },
    keys = {
      {
        "<leader>fwn",
        "<cmd>VimwikiMakeDiaryNote<cr>",
        desc = "Vimwiki Diary Node",
      },
      {
        "<leader>fwi",
        "<cmd>VimwikiDiaryIndex<cr>",
        desc = "Vimwiki Diary Index",
      },
    },
    init = function()
      vim.g.vimwiki_list = {
        { path = "~/vimwiki/", syntax = "markdown", ext = ".md" },
      }
    end,
  },

  {
    "fzf-lua",
    dependencies = {
      {
        "airblade/vim-rooter",
        init = function()
          vim.g.rooter_patterns = { ".git" }
          vim.g.rooter_buftypes = { "" }
        end,
      },
    },

    ---@type LazyKeysSpec[]
    keys = {
      -- {
      --   "<leader>gl",
      --   "<cmd>FzfLua git_commits<cr>",
      --   desc = "commits",
      -- },
      {
        "<leader>gC",
        "<cmd>FzfLua git_bcommits<cr>",
        desc = "Commits (current file)",
      },
      {
        "<leader>gb",
        "<cmd>FzfLua git_branches<cr>",
        desc = "branch",
      },
      {
        "<leader>gs",
        "<cmd>FzfLua git_stash<cr>",
        desc = "stash",
      },
    },
  },
}