return {
  "stevearc/conform.nvim",
  dependencies = { "mason.nvim" },
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        lua = { "stylua" },

        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        html = { "prettier" },
        yaml = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        graphql = { "prettier" },
        markdown = { "prettier" },
        ["markdown.mdx"] = { "prettier" },
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
