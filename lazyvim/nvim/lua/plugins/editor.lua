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
        git_status = false,
        buffers = false,
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
      { "<leader>gY" },
      { "<leader>gb" },
      { "<leader>gB" },

      {
        "<leader>gC",
        function()
          Snacks.picker.git_log_file()
        end,
        desc = "Commits (current file)",
      },
      {
        "<leader>gb",
        function()
          Snacks.picker.git_branches()
        end,
        desc = "git branches",
      },
      {
        "<leader>gO",
        function()
          Snacks.gitbrowse()
        end,
        desc = "git open in browser (git browse)",
      },
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
          git_stash_apply = function(picker, item, other)
            if not item then
              return
            end

            -- I don't know how to refresh the items, so close and reopen
            picker:close()
            local cmd = { "git", "stash", "apply", item.stash }
            Snacks.picker.util.cmd(cmd, function()
              Snacks.notify("Stash applied: `" .. item.stash .. "`", { title = "Snacks Picker" })
            end, { cwd = item.cwd })
            Snacks.picker.git_stash()
          end,
        },
        sources = {
          projects = {
            dev = { "~/code" },
            projects = { "~/dotfiles" },
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
        },
      },
    },
  },
}
