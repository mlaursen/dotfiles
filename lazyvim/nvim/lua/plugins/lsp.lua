---@class LspCodeActionCommand
---@field command string
---@field title string
---@field arguments unknown[]

---@class LspCodeAction
---@field diagnostic lsp.Diagnostic[]
---@field command LspCodeActionCommand?
---@field kind lsp.CodeActionTriggerKind
---@field title string
---@field isPreferred boolean

---@param action LspCodeAction
---@return boolean
local function is_exhaustive_deps(action)
  return action.kind == "quickfix"
      and action.command
      and action.command.command == "eslint.applySuggestion"
      and action.command.arguments[1].ruleId == "react-hooks/exhaustive-deps"
    or false
end

---The isPreferred flag doesn't exist on the exhaustive-deps eslint rule for
---some reason, so here's a hacky way to allow the quickfix behavior for that
---rule
---@param action LspCodeAction
---@return boolean
local function is_quickfix(action)
  return action.isPreferred or is_exhaustive_deps(action)
end

return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "cspell",
        "css-lsp",
        "cssmodules-language-server",
        "eslint-lsp",
        "html-lsp",
        "json-lsp",
        "lua-language-server",
        "stylua",
        "lua-language-server",
        "graphql-language-service-cli",
        "stylelint-lsp",
        -- "sonarlint-language-server",
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
      -- Be aware that you also will need to properly configure your LSP server to
      -- provide the inlay hints.
      inlay_hints = {
        enabled = false,
      },
      -- Enable this to enable the builtin LSP code lenses on Neovim >= 0.10.0
      -- Be aware that you also will need to properly configure your LSP server to
      -- provide the code lenses.
      codelens = {
        enabled = false,
      },
      -- add any global capabilities here
      capabilities = {},
      -- options for vim.lsp.buf.format
      -- `bufnr` and `filter` is handled by the LazyVim formatter,
      -- but can be also overridden when specified
      format = {
        formatting_options = nil,
        timeout_ms = nil,
      },
      -- LSP Server Settings
      ---@type lspconfig.options
      servers = {
        tsserver = {
          settings = {
            completions = {
              completeFunctionCalls = true,
            },
            javascript = {
              format = {
                enable = false,
              },
            },
            typescript = {
              format = {
                enable = false,
              },
            },
          },
        },
        stylelint_lsp = {
          filetypes = { "css", "scss" },
          settings = {
            stylelintplus = {},
          },
        },
      },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        -- example to setup with typescript.nvim
        -- tsserver = function(_, opts)
        --   require("typescript").setup({ server = opts })
        --   return true
        -- end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    },

    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()

      keys[#keys + 1] = {
        "<leader>cq",
        function()
          vim.lsp.buf.code_action({
            apply = true,
            filter = is_quickfix,
          })
        end,
        desc = "Code action quickfix",
      }
    end,
  },
}
