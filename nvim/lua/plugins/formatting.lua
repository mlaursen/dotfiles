return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        graphql = { "prettier" },
        lua = { "stylua" },
        python = { "isort", "black" },
      },
      format_on_save = {
        async = false,
        timeout_ms = 500,
        lsp_fallback = true,
      },
    })

    vim.keymap.set({ "n", "v" }, "ff", function()
      conform.format({
        async = false,
        timeout_ms = 500,
        lsp_fallback = true,
      })
    end)
  end,
}