return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        javascript = { "eslint_d", "prettier" },
        javascriptreact = { "eslint_d", "prettier" },
        typescript = { "eslint_d", "prettier" },
        typescriptreact = { "eslint_d", "prettier" },

        htmldjango = { "djlint" },
        jinja = { "djlint" },
      },
      formatters = {
        djlint = {
          prepend_args = { "--profile", "nunjucks" },
        },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        htmldjango = { "djlint" },
        jinja = { "djlint" },
      },
    },
  },
}
