return {
  "editorconfig/editorconfig-vim",
  {
    -- this one supports truecolors
    "lifepillar/vim-solarized8",
    -- "altercation/vim-colors-solarized"
    config = function()
      vim.opt.background = "dark"
      vim.opt.termguicolors = true
      vim.cmd([[colorscheme solarized8]])
    end,
  },

  {
    "vim-airline/vim-airline",
    dependencies = {
      {
        "vim-airline/vim-airline-themes",
        dependencies = {
          "lifepillar/vim-solarized8",
        },
        config = function()
          vim.g.airline_theme = "solarized"
          vim.g.airline_solarized_bg = "dark"
        end,
      }
    },
  },

  "hail2u/vim-css3-syntax", -- updates vim"s built-in css to support CSS3
  "cakebaker/scss-syntax.vim",
  {
    "pangloss/vim-javascript",
    config = function()
      vim.g.javascript_plugin_jsdoc = 1
    end,
  },
  "neoclide/jsonc.vim",
  {
    "HerringtonDarkholme/yats.vim",
    build = {
      -- I don"t want the snippets provided by this package as I like my own vim-react-snippets
      "rm -rf UltiSnips"
    },
  },
  "maxmellon/vim-jsx-pretty",
  
  "jparise/vim-graphql",
  "hashivim/vim-terraform",
}