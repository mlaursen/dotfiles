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
      --  https://mason-registry.dev/registry/list
      ensure_installed = {
        "css-lsp",
        "cssmodules-language-server",
        "eslint-lsp",
        "graphql-language-service-cli",
        "html-lsp",
        "json-lsp",
        "lua-language-server",
        "stylelint-lsp",
        "stylua",
        -- "sonarlint-language-server",
        "yaml-language-server",
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

      -- These are non-defaults
      diagnostics = {
        -- inline virtual diagnostics is way too noisy use Trouble or jumping
        -- to diagnostics to see the messages instead
        virtual_text = false,
      },

      -- LSP Server Settings
      ---@type lspconfig.options
      servers = {
        tsserver = {
          settings = {
            javascript = {
              format = {
                enable = false,
              },
            },
            typescript = {
              format = {
                enable = false,
              },
              suggest = {
                autoImports = false,
                completeFunctionCalls = false,
                includeCompletionsForImportStatements = false,
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
        yamlls = {
          settings = {
            yaml = {
              schemas = {
                ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = {
                  "/gitlab/*.yml",
                  "/gitlab/*.yaml",
                },
              },
            },
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

      -- allow quick fixes with eslint for type imports, react hook dependency
      -- arrays, etc
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