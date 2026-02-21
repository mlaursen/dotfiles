return {
  {
    "vimwiki/vimwiki",
    lazy = "VeryLazy",
    cmd = {
      "VimwikiDiaryIndex",
      "VimwikiMakeDiaryNote",
    },
    keys = {
      {
        "<leader>fwn",
        "<cmd>VimwikiMakeDiaryNote<cr>",
        desc = "Vimwiki Diary Note",
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
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          -- show hidden files by default. I rely on gitignore and would prefer
          -- to disable this if I don't want to find it
          files = {
            hidden = true,
          },

          ---@type snacks.picker.projects.Config
          projects = {
            dev = { "~/code" },
            projects = { "~/dotfiles" },
            confirm = "picker",
          },

          explorer = {
            hidden = true,
            win = {
              input = {
                keys = {
                  -- do not close if I hit esc twice. only allow `q`
                  ["<esc>"] = { "", mode = "n" },
                },
              },
              list = {
                keys = {
                  -- do not close if I hit esc twice. only allow `q`
                  ["<esc>"] = { "", mode = "n" },
                },
              },
            },
          },
        },

        formatters = {
          file = {
            -- do not truncate the paths since it makes finding files difficult
            truncate = 10000,
          },
        },
      },
      lazygit = {
        editCommand = "nvim",
      },
    },
  },
}
