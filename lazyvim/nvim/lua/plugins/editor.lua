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
    keys = {
      -- disable
      -- { "<leader>gY" },
      -- { "<leader>gb" },
      -- { "<leader>gB", "<cmd>Git blame<cr>", desc = "blame" },
      -- { "<leader>gp" },
      -- { "<leader>gP" },

      -- https://github.com/folke/snacks.nvim/blob/fe7cfe9800a182274d0f868a74b7263b8c0c020b/docs/gh.md#-usage
      -- remap from gp and gP since I use those
      -- {
      --   "<leader>gr",
      --   function()
      --     Snacks.picker.gh_pr()
      --   end,
      --   desc = "GitHub Pull Requests (open)",
      -- },
      -- {
      --   "<leader>gR",
      --   function()
      --     Snacks.picker.gh_pr({ state = "all" })
      --   end,
      --   desc = "GitHub Pull Requests (all)",
      -- },

      --
      -- {
      --   "<leader>gC",
      --   function()
      --     Snacks.picker.git_log_file()
      --   end,
      --   desc = "Commits (current file)",
      -- },
      -- {
      --   "<leader>gb",
      --   function()
      --     Snacks.picker.git_branches()
      --   end,
      --   desc = "git branches",
      -- },
      -- {
      --   "<leader>gO",
      --   function()
      --     Snacks.gitbrowse()
      --   end,
      --   desc = "git open in browser (git browse)",
      -- },
    },
    opts = {
      picker = {
        actions = {
          ---@type snacks.picker.Action.spec
          git_stash_drop = function(picker, item)
            if not item then
              return
            end

            -- I don't know how to refresh the items, so close and reopen
            picker:close()
            local cmd = { "git", "stash", "drop", item.stash }
            Snacks.picker.util.cmd(cmd, function()
              Snacks.notify("Stash dropped: `" .. item.stash .. "`", { title = "Snacks Picker" })
            end, { cwd = item.cwd })
            Snacks.picker.git_stash()
          end,
          ---@type snacks.picker.Action.spec
          git_stash_apply = function(picker, item)
            if not item then
              return
            end

            local cmd = { "git", "stash", "apply", item.stash }
            Snacks.picker.util.cmd(cmd, function()
              Snacks.notify("Stash applied: `" .. item.stash .. "`", { title = "Snacks Picker" })
            end, { cwd = item.cwd })
            picker:close()
          end,
        },
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
          git_stash = {
            win = {
              input = {
                keys = {
                  ["<c-x>"] = { "git_stash_drop", mode = { "n", "i" } },
                },
              },
            },
          },
          git_branches = {
            all = true,
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
