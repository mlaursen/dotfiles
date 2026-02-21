return {
  {
    "tpope/vim-fugitive",
    enabled = false,
    lazy = "VeryLazy",
    cmd = {
      "G",
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
      --
      -- { "s", group = "file", desc = "Stage" },
      -- { "u", group = "file", desc = "Unstage" },
      -- { "-", group = "file", desc = "Stage or unstage" },
      -- { "U", group = "file", desc = "Unstage everything" },
      -- { "X", group = "file", desc = "Discard " },
      -- { "=", group = "file", desc = "Toggle inline diff" },
      -- { ">", group = "file", desc = "Insert inline diff" },
      -- { "<", group = "file", desc = "Remove inline diff" },
      -- { "gI", group = "file", desc = "Add file to .git/info/exclude" },
      -- { "I", group = "file", desc = "Git add/reset --patch" },
      -- { "P", group = "file", desc = "Git add/reset --patch" },
      --
      -- { "dd", desc = ":Gdiffsplit" },
      -- { "dv", desc = ":Gvdiffsplit" },
      -- { "ds", desc = ":Gdiffsplit" },
      -- { "dh", desc = ":Gdiffsplit" },
      -- { "dq", desc = "Close other diffs" },
      -- { "d?", desc = "Diff help" },
      --
      -- { "o", desc = "Open" },
      -- { "gO", desc = "Open in vsplit" },
      -- { "O", desc = "Open in tab" },
      -- { "p", desc = "Preview" },
      -- { "~", desc = "Open nth ancestor" },
      -- { "P", desc = "Open nth parent" },
      -- { "C", desc = "Open commit" },
      -- { "(", desc = "Next file, hunk, revision" },
      -- { ")", desc = "Prev file, hunk, revision" },
      -- { "[c", desc = "Prev hunk" },
      -- { "]c", desc = "Next hunk" },
      -- { "[/", desc = "Prev file" },
      -- { "[m", desc = "Prev file" },
      -- { "]/", desc = "Next file" },
      -- { "]m", desc = "Next file" },
      -- { "i", desc = "Jump to next file/hunk" },
      -- { "[[", desc = "Jump backward" },
      -- { "]]", desc = "Jump forward" },
      -- { "[]", desc = "Jump ends backward" },
      -- { "][", desc = "Jump ends forward" },
      -- { "*", desc = "Search for +-" },
      -- { "#", desc = "Search for +- (backward)" },
      --
      -- { "gu", group = "file", desc = "Go to Untracked/unstaged" },
      -- { "gU", group = "file", desc = "Go to Unstaged" },
      -- { "gs", group = "file", desc = "Go to Staged" },
      -- { "gp", group = "file", desc = "Go to Unpushed" },
      -- { "gP", group = "file", desc = "Go to Unpulled" },
      -- { "gr", group = "file", desc = "Go to Rebasing" },
      -- { "gi", group = "file", desc = "Go to .git/info/exclude" },
      --
      -- { "cc", desc = "Commit" },
      -- { "cvc", desc = "Commit -v" },
      -- { "ca", desc = "Amend commit" },
      -- { "cva", desc = "Amend commit -v" },
      -- { "ce", desc = "Edit commit" },
      -- { "cw", desc = "Reword commit" },
      -- { "cW", desc = "amend! reword commit" },
      -- { "cF", desc = "fixup! reword commit" },
      -- { "cs", desc = "squash! commit" },
      -- { "cS", desc = "squash! rebase" },
      -- { "cn", desc = "squash! commit edit" },
      -- { "c<space>", desc = "Git commit ..." },
      --
      -- { "crc", desc = "Revert" },
      -- { "crn", desc = "Revert --no-edit" },
      -- { "cr<space>", desc = "Git revert ..." },
      -- { "cm<space>", desc = "Git merge ..." },
      -- { "c?", desc = "Commit help" },
      --
      -- { "coo", desc = "Checkout" },
      -- { "cb<space>", desc = "Git branch ..." },
      -- { "co<space>", desc = "Git checkout ..." },
      -- { "cb?", desc = "Checkout help" },
      -- { "co?", desc = "Checkout help" },
      --
      -- { "cz", desc = "+stash" },
      -- { "czz", desc = "Stash" },
      -- { "czw", desc = "Stash --keep-index" },
      -- { "czs", desc = "Stash push" },
      -- { "czA", desc = "Apply stash" },
      -- { "cza", desc = "Apply stash preserve index" },
      -- { "czP", desc = "Pop stash" },
      -- { "czp", desc = "Pop stash preserve index" },
      -- { "cz<space>", desc = "Git stash ..." },
      -- { "cz?", desc = "Stash help" },
      --
      -- { "r", desc = "+rebase" },
      -- { "ri", desc = "Interactive rebase" },
      -- { "u", desc = "Interactive rebase" },
      -- { "rf", desc = "Rebase autosquash" },
      -- { "ru", desc = "upstream rebase" },
      -- { "rp", desc = "push rebase" },
      -- { "rr", desc = "resume rebase" },
      -- { "rs", desc = "Skip current commit rebase" },
      -- { "ra", desc = "Abort rebase" },
      -- { "re", desc = "Edit rebase todo list" },
      -- { "rw", desc = "Reword rebase" },
      -- { "rm", desc = "Edit rebase" },
      -- { "rd", desc = "Drop rebase" },
      -- { "r<space>", desc = "Git rebase ..." },
      -- { "r?", desc = "Rebase help" },
      --
      -- { "gq", desc = "Close" },
      -- { ":", desc = "Command line" },
      -- { "g?", desc = "help" },
    },
  },

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
    "fzf-lua",
    enabled = vim.g.lazyvim_picker == "fzf",
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

    opts = function(_, opts)
      local path = require("fzf-lua.path")
      local utils = require("fzf-lua.utils")

      --- https://github.com/ibhagwan/fzf-lua/blob/ebb89e4e4065e31b029eee8f618e1ca660f41f35/lua/fzf-lua/actions.lua#L577-L600
      local git_switch_create = function(selected, opts)
        if not selected[1] then
          return
        end
        local cmd = path.git_cwd({ "git", "checkout" }, opts)
        local git_ver = utils.git_version()
        -- git switch was added with git version 2.23
        if git_ver and git_ver >= 2.23 then
          cmd = path.git_cwd({ "git", "switch" }, opts)
        end
        -- remove anything past space
        local branch = selected[1]:match("[^ ]+")
        -- do nothing for active branch
        if branch:find("%*") ~= nil then
          return
        end
        if branch:find("^remotes/") then
          -- NOTE: This is the new part
          -- table.insert(cmd, "--detach")
          branch = branch:gsub("remotes/origin/", "")
        end
        table.insert(cmd, branch)
        local output, rc = utils.io_systemlist(cmd)
        if rc ~= 0 then
          utils.err(unpack(output))
        else
          utils.info(unpack(output))
          vim.cmd("checktime")
        end
      end
      return vim.tbl_deep_extend("force", opts, {
        git = {
          branches = {
            actions = {
              ["ctrl-s"] = { git_switch_create, pos = 3 },
            },
          },
        },
      })
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
