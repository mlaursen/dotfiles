return {
  "tpope/vim-fugitive",

  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          always_show = {
            ".env.local",
            ".env.development.local",
            ".env.production.local",
          },
          hide_dotfiles = false,
        },
      },
    },
  },

  {
    "nvim-telescope/telescope.nvim",
    -- keys = {
    --   {
    --     "<C-s>",
    --     function()
    --       require("telescope.actions").select_horizontal()
    --     end,
    --     desc = "Select file horizontal",
    --   },
    -- },
    -- opts = {
    --   defaults = {
    --     mappings = {
    --       ["<C-s>"] = require("telescope.actions").select_horizontal,
    --     },
    --   },
    -- },
    opts = {
      extensions = {
        fzf = {
          fuzzy = true,
          case_mode = "smart_case",
          override_file_sorter = true,
          override_generic_sorter = true,
        },
      },
    },
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
  },

  {
    "vimwiki/vimwiki",
    cmd = {
      "VimwikiDiaryIndex",
      "VimwikiMakeDiaryNote",
    },
    init = function()
      vim.g.vimwiki_list = {
        { path = "~/vimwiki/", syntax = "markdown", ext = ".md" },
      }
    end,
  },
}
