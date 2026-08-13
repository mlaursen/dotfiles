return {
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters = opts.formatters or {}
      opts.formatters_by_ft = opts.formatters_by_ft or {}

      if vim.g.mlaursen_use_oxc then
        opts.formatters_by_ft.javascript = { "oxlint", "oxfmt" }
        opts.formatters_by_ft.javascriptreact = { "oxlint", "oxfmt" }
        opts.formatters_by_ft.typescript = { "oxlint", "oxfmt" }
        opts.formatters_by_ft.typescriptreact = { "oxlint", "oxfmt" }
        opts.formatters_by_ft.scss = { "oxfmt" }
        opts.formatters_by_ft.markdown = { "oxfmt" }
      else
        opts.formatters_by_ft.javascript = { "eslint_d", "prettier" }
        opts.formatters_by_ft.javascriptreact = { "eslint_d", "prettier" }
        opts.formatters_by_ft.typescript = { "eslint_d", "prettier" }
        opts.formatters_by_ft.typescriptreact = { "eslint_d", "prettier" }
      end

      if vim.g.mlaursen_use_lit then
        opts.formatters_by_ft.htmldjango = { "djlint" }
        opts.formatters_by_ft.jinja = { "djlint" }

        opts.formatters.djlint = {
          prepend_args = { "--profile", "nunjucks" },
        }
      end
    end,
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
