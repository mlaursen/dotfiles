return {
  "editorconfig/editorconfig-vim",

  -- "twe4ked/vim-colorscheme-switcher",

  -- {
  --   -- this one supports truecolors
  --   "lifepillar/vim-solarized8",
  --   -- "altercation/vim-colors-solarized"
  --   config = function()
  --     vim.opt.background = "dark"
  --     vim.g.solarized_old_cursor_style = 1
  --     vim.cmd([[colorscheme solarized8]])
  --   end,
  -- },
  {
    "EdenEast/nightfox.nvim",
    config = function()
      vim.opt.background = "dark"
      require("nightfox").setup({
        options = {
          colorblind = {
            enable = true,
            -- simulate_only = true,
            severity = {
              protan = 0.8,
              deutan = 1,
              tritan = 0.3,
            },
          },
        },
      })

      vim.cmd.colorscheme("nightfox")
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },

    config = function()
      require("lualine").setup({
        options = {
          theme = "nightfox",
        },
        extensions = {
          "fugitive",
          "fzf",
          "lazy",
          "mason",
          "nerdtree",
        }
      })
    end,
  },

  -- {
  --   "vim-airline/vim-airline",
  --   dependencies = {
  --     {
  --       "vim-airline/vim-airline-themes",
  --       dependencies = {
  --         "lifepillar/vim-solarized8",
  --       },
  --       config = function()
  --         vim.g.airline_theme = "solarized"
  --         vim.g.airline_solarized_bg = "dark"
  --       end,
  --     }
  --   },
  -- },

  -- "hail2u/vim-css3-syntax", -- updates vim"s built-in css to support CSS3
  -- "cakebaker/scss-syntax.vim",
  -- {
  --   "pangloss/vim-javascript",
  --   config = function()
  --     vim.g.javascript_plugin_jsdoc = 1
  --   end,
  -- },
  -- "neoclide/jsonc.vim",
  -- {
  --   "HerringtonDarkholme/yats.vim",
  --   build = {
  --     -- I don"t want the snippets provided by this package as I like my own vim-react-snippets
  --     "rm -rf UltiSnips"
  --   },
  -- },
  -- "maxmellon/vim-jsx-pretty",
  
  -- "jparise/vim-graphql",
  -- "hashivim/vim-terraform",
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",

    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = {
        "bash",
        "css",
        "diff",
        "graphql",
        "javascript",
        "json",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "regex",
        "scss",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      },
    },

    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}